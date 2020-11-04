//
//  LikedComments.swift
//  projectX
//
//  Created by Jake Nations on 10/23/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct LikedComment: Identifiable, Codable{
    
    @DocumentID var id: String?
    
    /// ID of the liked comment
    var commentID: String
    
    //TODO: Probably have some more varaibles and implement the firebase increment funcion here
    

    

    
}
extension LikedComment{
    /// returns a new post object
    public init(commentID: String) {
        self.commentID = commentID
    }
}

