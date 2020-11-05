//
//  FollowedStations.swift
//  projectX
//
//  Created by Jake Nations, Radomyr Bezghin on 10/23/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct FollowedStation : Identifiable, Codable{
    
    ///uid of this document
    @DocumentID var id: String?
    
    ///userid of the user that follows a station
    var userID: String
    
    ///stationid of station that is being followed
    var stationID: String
    
    ///station name (might  be redundant, but helps to make less requests)
    var stationName: String
    
    ///date when user followed this station
    var date: Date

}
extension FollowedStation{
    
    public init(userID: String, stationID: String, stationName: String){
        self.userID = userID
        self.stationID = stationID
        self.stationName = stationName
        self.date = Date()
    }
    
}
