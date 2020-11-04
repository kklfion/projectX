//
//  AcceptedMissions.swift
//  projectX
//
//  Created by Jake Nations on 10/23/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct AcceptedMission: Identifiable, Codable{
    
    @DocumentID var id: String?
    
    /// ID of the user who created the mission
    var userID: String

    /// ID of the mission which was accepted
    var missionID: String
    
    /// Date of the time of acceptance
    var date: Date
    

    
}
extension AcceptedMission{
    /// returns a new post object
    public init(userID: String,
                missionID: String,
                date: Date) {
        
        self.userID = userID
        self.missionID = missionID
        self.date = date
    }
}
