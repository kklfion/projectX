//
//  LikedPosts.swift
//  projectX
//
//  Created by Jake Nations on 10/23/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

struct Like: Identifiable, Codable{
    
    @DocumentID var id: String?
    
    ///userid of the user that liked a post
    var userID: String
    
    ///postsid of a post that was liked
    var postID: String
    
    ///date when user liked that post
    var date: Date
    
}
extension Like{
    /// returns a new post object
    public init(userID: String, postID: String){
        self.userID = userID
        self.postID = postID
        self.date = Date()
    }
}
