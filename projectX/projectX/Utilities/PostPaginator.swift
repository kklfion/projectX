//
//  PostPaginator.swift
//  projectX
//
//  Created by Radomyr Bezghin on 1/5/21.
//  Copyright © 2021 Radomyr Bezghin. All rights reserved.
//

import FirebaseFirestore

class PostPaginator {
    
    private var query: Query!
    private var lastDocumentSnapshot: DocumentSnapshot!
    private var db = Firestore.firestore()
    
    var isFetchingMore = false
    
    func queryPostWith(pagination: Bool = false, completion: @escaping (Result<[Post], Error>) -> Void){
        
        let posts = [Post]()
        
        if pagination {
            isFetchingMore = true
        }
        
        if !pagination { //first call
            query = db.posts.order(by: "date").limit(to: 10)
            print("First 10 posts loaded")
        } else {
            //FIXME: user lastdocsnapshot
            //query = db.posts.order(by: "date").start(afterDocument: lastDocumentSnapshot).limit(to: 10)
            query = db.posts.order(by: "date").limit(to: 10)
            print("Next 10 posts loaded")
        }
        
        query.getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let documents = snapshot?.documents else { return }
                let genericDocs = documents.compactMap { (querySnapshot) -> Post? in
                    return try? querySnapshot.data(as: Post.self)
                }
                completion(.success(genericDocs))
                //self.lastDocumentSnapshot = snapshot!.documents.last
            }
            self.isFetchingMore = false
        }

    }
}
