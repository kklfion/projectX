//
//  Followers.swift
//  projectX
//
//  Created by Jake Nations on 10/23/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Follower : Identifiable, Codable{
    
    @DocumentID var id: String?
    
    /// ID of user
    var userID: String
    
    /// ID of person that user is following
    var followingUserWithID: String
    
    var date: Date
}
extension Follower{
    /// returns a new post object
    public init(userID: String, followingUserWithID: String) {
        self.userID = userID
        self.followingUserWithID = followingUserWithID
        self.date = Date()
    }
}
