//
//  PostPaginator.swift
//  projectX
//
//  Created by Radomyr Bezghin on 1/5/21.
//  Copyright © 2021 Radomyr Bezghin. All rights reserved.
//

import FirebaseFirestore

/*
 Three types of fetches:
 1. fetch all new posts
 2. fetch posts for userid
 3. fetch posts for station
 */
enum PaginatorType{
    ///home feed
    case generalFeed
    ///station feed
    case stationFeed
    ///user profile history
    case userPosts
}

class PostPaginator {
    private var paginatorType: PaginatorType
    
    private var query: Query?
    
    private var defaultQuery: Query
    
    private var lastDocumentSnapshot: DocumentSnapshot?
    private var db = Firestore.firestore()
    private let documentsPerQuery = 6
    
    var isFetching = false
    
    init(type: PaginatorType, stationID: String? = nil, userID: String? = nil) {
        self.paginatorType = type
        switch paginatorType {
        case .generalFeed:
            self.defaultQuery = db.posts.order(by: "date", descending: false)
        case .stationFeed:
            guard let id = stationID else {
                self.defaultQuery = db.posts.order(by: "date", descending: false)
                return
            }
            self.defaultQuery = NetworkManager.shared.db.posts.whereField(FirestoreFields.stationID.rawValue, isEqualTo: id)
        case .userPosts:
            guard let id = userID else {
                self.defaultQuery = db.posts.order(by: "date", descending: false)
                return
            }
            self.defaultQuery = NetworkManager.shared.db.posts.whereField(FirestoreFields.userInfoUserID.rawValue, isEqualTo: id)
        }
    }
    
    func queryPostWith(pagination: Bool, completion: @escaping (Result<[Post], Error>) -> Void){
        isFetching = true
        if pagination {
            guard let  lastDocumentSnapshot = lastDocumentSnapshot else { return }
            //query = db.posts.order(by: "date", descending: false).start(afterDocument: lastDocumentSnapshot).limit(to: documentsPerQuery)
            query = query?.start(afterDocument: lastDocumentSnapshot).limit(to: documentsPerQuery)
        }else {
            query = defaultQuery.limit(to: documentsPerQuery)
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
                    completion(.success(genericDocs))
                    self.lastDocumentSnapshot = snapshot!.documents.last
                }
                self.isFetching = false
            }
        }

    }
}
