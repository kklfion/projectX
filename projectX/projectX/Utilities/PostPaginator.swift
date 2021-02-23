//
//  PostPaginator.swift
//  projectX
//
//  Created by Radomyr Bezghin on 1/5/21.
//  Copyright © 2021 Radomyr Bezghin. All rights reserved.
//

import FirebaseFirestore

///Feed types to init feed
enum FeedType: Equatable {
    /// to bring up most recent posts, need to provide userID as an argument
    case userHistoryFeed(String)
    /// you can provide an optional id, home doesnt need it but lounge for station needs a station id
    case lounge(String?)
    /// you can provide an optional id, home doesnt need it but busstop for station needs a station id
    case busStop(String?)
    //case university //most recent posts from all the subcolleges
}
class PostPaginator {
    
    ///initial first fetch should not have pagination enabled
    var isInitialFetching = true
    
    ///if paginator is currently fetching dont fetch more
    var isFetching = false
    
    ///set by viewController
    private let defaultQuery: Query
    
    ///used for pagianation
    private var query: Query?
    
    ///to fetch documents that follow previously fetched documents
    private var lastDocumentSnapshot: DocumentSnapshot?

    ///limit of docs fetched ech query
    private var documentsPerQuery = 6
    ///to sort by likes(special case for lounge)
    private var feedType: FeedType?
    
    private let loungeDate = Calendar.current.date(byAdding: .hour, value: -84, to: Date())
    
    ///home feed
    init(feedType: FeedType) {
        switch feedType {
        case .busStop:
            self.defaultQuery = NetworkManager.shared.db.posts.order(by: "date", descending: true)
        case .lounge:
            self.defaultQuery = NetworkManager.shared.db.posts.whereField(FirestoreFields.date.rawValue, isGreaterThan: loungeDate)
            documentsPerQuery = 100
            self.feedType = feedType
        default:
            fatalError()
        }
    }
    ///station feed
    init(stationID id: String, feedType: FeedType){
        switch feedType {
        case .busStop(let stationid):
            guard  let stationid = stationid else {fatalError()}
            self.defaultQuery = NetworkManager.shared.db.posts.whereField(FirestoreFields.stationID.rawValue, isEqualTo: stationid).order(by: "date", descending: true)
        case .lounge(let stationid):
            guard  let stationid = stationid else {fatalError()}
            self.defaultQuery = NetworkManager.shared.db.posts.whereField(FirestoreFields.stationID.rawValue, isEqualTo: stationid).whereField(FirestoreFields.date.rawValue, isGreaterThan: loungeDate)
            documentsPerQuery = 100
            self.feedType = feedType
        default:
            fatalError()
        }
    }
    ///user profile history
    init(userID id: String){
        self.defaultQuery = NetworkManager.shared.db.posts.whereField(FirestoreFields.userInfoUserID.rawValue, isEqualTo: id).order(by: "date", descending: true)
    }
    ///forces paginator to use default query
    func resetPaginator(){
        isInitialFetching = true
    }
    
    func queryPostWith(completion: @escaping (Result<[Post], Error>) -> Void){
        isFetching = true
        if isInitialFetching {
            query = defaultQuery.limit(to: documentsPerQuery)
            isInitialFetching = false
        }else {
            guard let  lastDocumentSnapshot = lastDocumentSnapshot else { return }
            query = query?.start(afterDocument: lastDocumentSnapshot).limit(to: documentsPerQuery)
        }
        //FIXME: delay added to show spinner
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.query?.getDocuments { (snapshot, error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    guard let documents = snapshot?.documents else { return }
                    let genericDocs = documents.compactMap { (querySnapshot) -> Post? in
                        return try? querySnapshot.data(as: Post.self)
                    }
                    if self.feedType == .lounge(nil){
                        let posts = genericDocs.sorted { (post1, post2) -> Bool in
                            return post1.likes > post2.likes
                        }
                        completion(.success(posts))
                    } else{
                        completion(.success(genericDocs))
                    }
                    
                    self.lastDocumentSnapshot = snapshot!.documents.last
                }
                self.isFetching = false
            }
        }

    }
}
