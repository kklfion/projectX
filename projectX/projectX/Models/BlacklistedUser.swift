//
//  BlacklistedUser.swift
//  projectX
//
//  Created by Jake Nations on 10/23/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct BlacklistedUser : Identifiable, Codable{
    
    @DocumentID var id: String?
    
    /// ID of the blocked user
    var userID: String
    
    //TODO: Probably have some more varaibles and implement the firebase increment funcion here
    

    
}
extension BlacklistedUser{
    /// returns a new post object
    public init(userID: String) {
        self.userID = userID
    }
}
