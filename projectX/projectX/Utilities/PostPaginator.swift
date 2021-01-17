//
//  PostPaginator.swift
//  projectX
//
//  Created by Radomyr Bezghin on 1/5/21.
//  Copyright © 2021 Radomyr Bezghin. All rights reserved.
//

import FirebaseFirestore

class PostPaginator {
    
    ///initial first fetch should not have pagination enabled
    var isInitialFetching = true
    
    ///if paginator is currently fetching dont fetch more
    var isFetching = false
    
    ///set by viewController
    private let defaultQuery: Query
    ///used for pagianation
    private var query: Query?
    
    private var lastDocumentSnapshot: DocumentSnapshot?

    private let documentsPerQuery = 6
    
    ///home feed
    init() {
        self.defaultQuery = NetworkManager.shared.db.posts.order(by: "date", descending: true)
    }
    ///station feed
    init(stationID id: String){
        self.defaultQuery = NetworkManager.shared.db.posts.whereField(FirestoreFields.stationID.rawValue, isEqualTo: id).order(by: "date", descending: true)
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
                    completion(.success(genericDocs))
                    self.lastDocumentSnapshot = snapshot!.documents.last
                }
                self.isFetching = false
            }
        }

    }
}
