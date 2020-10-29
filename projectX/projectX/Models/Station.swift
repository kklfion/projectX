//
//  Station.swift
//  projectX
//
//  Created by Radomyr Bezghin on 9/10/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

struct Station:Identifiable, Codable{
    /// property wrapper that stores id of the document associated with data
    @DocumentID var id: String?

    /// brief description of the station.
    var info: String

    /// The name of the station.
    var stationName: String

    /// The number of followers of the station.
    var followers: Int?

    /// The date when station was created.
    var date: Date
    
    /// Station photo url stored in the Firestore
    var frontImageURL: URL?
    
    /// Station photo url stored in the Firestore
    var backgroundImageURL: URL?
    
    /// Station's post count
    var postCount: Int?
    
    /// IF this station is a "sub-station" this is the ID for that parent station
    var parentStationID: String?
    
    /// If substation = True, if not = False
    var isSubStation: Bool?
    
    
}
extension Station{
    init(info: String,
                stationName: String,
                followers: Int,
                date: Date,
                frontImageURL: URL?,
                backgroundImageURL: URL?,
                postCount: Int? = 0,
                parentStationID: String? = "N/A",
                isSubStation: Bool? = false) {
        self.info = info
        self.stationName = stationName
        self.followers = followers
        self.date = date
        self.frontImageURL = frontImageURL
        self.backgroundImageURL = backgroundImageURL
        self.postCount = postCount
        self.parentStationID = parentStationID
        self.isSubStation = isSubStation
        
    }
}
