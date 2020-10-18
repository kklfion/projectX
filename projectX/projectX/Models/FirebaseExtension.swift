//
//  FirebaseExtension.swift
//  projectX
//
//  Created by Radomyr Bezghin on 9/10/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import FirebaseFirestore

extension Firestore{
    ///Returns a reference to the top level collections
    var posts: CollectionReference{
        return self.collection("posts")
    }
    ///Returns a reference to the top level collections
    var stations: CollectionReference{
        return self.collection("stations")
    }
    ///Returns a reference to the top level collections
    var comments: CollectionReference{
        return self.collection("comments")
    }
    ///Returns a reference to the top level collections
    var users: CollectionReference{
        return self.collection("users")
    }
    var boards: CollectionReference{
        return self.collection("boards")
    }
}


extension Firestore{
//    /// Writes to the top-level posts collection, overwriting data
//    /// if the  ID already exists.
//    func add(post: Post) {
//      self.posts.document(post.documentID).setData(post.documentData)
//    }
//    /// Writes to the top-level posts collection, overwriting data
//    /// if the  ID already exists.
//    func add(station: Station) {
//      self.stations.document(station.documentID).setData(station.documentData)
//    }
//    /// Writes to the top-level posts collection, overwriting data
//    /// if the  ID already exists.
//    func add(comment: Comment) {
//      self.comments.document(comment.documentID).setData(comment.documentData)
//    }
//    /// Writes to the top-level posts collection, overwriting data
//    /// if the  ID already exists.
//    func add(user: User) {
//      self.users.document(user.documentID).setData(user.documentData)
//    }
}

extension WriteBatch{
//    /// Writes  to the top-level post collection, overwriting data if
//    /// already exists.
//    func add(post: Post) {
//      let document = Firestore.firestore().posts.document(post.documentID)
//      self.setData(post.documentData, forDocument: document)
//    }
//    /// Writes  to the top-level post collection, overwriting data if
//    /// already exists.
//    func add(station: Station) {
//      let document = Firestore.firestore().stations.document(station.documentID)
//      self.setData(station.documentData, forDocument: document)
//    }
//    /// Writes  to the top-level post collection, overwriting data if
//    /// already exists.
//    func add(comment: Comment) {
//      let document = Firestore.firestore().comments.document(comment.documentID)
//      self.setData(comment.documentData, forDocument: document)
//    }
//    /// Writes  to the top-level post collection, overwriting data if
//    /// already exists.
//    func add(user: User) {
//      let document = Firestore.firestore().users.document(user.documentID)
//      self.setData(user.documentData, forDocument: document)
//    }
}
