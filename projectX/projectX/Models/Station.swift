//
//  Station.swift
//  projectX
//
//  Created by Radomyr Bezghin on 9/10/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

/// an enum that stores type of a station. Used to distinguish stations with different UI and queries
enum StationType: String, Codable{
    
    /// parent station will have substations as second tableView list
    case parentStation
    
    /// is a "main" station that doesn't have substations and will display missions
    case station
    
    /// is a substation of a parentstation, will be displayed in the parentStation list and it will have missions as second tableview
    case subStation
}

struct Station:Identifiable, Codable{
    
    /// property wrapper that stores id of the document associated with data
    @DocumentID var id: String?

    /// brief description of the station.
    var info: String

    /// The name of the station.
    var stationName: String

    /// The number of followers of the station.
    var followers: Int

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
    
    /// If station substation is substations then it can be displayed in the list of substations of the parentStation
    var isSubStation: Bool?
    
    /// If station hasSubStations then it will display a list of substations as second tableview, else it will display missions
    var stationType: StationType
    
}
extension Station{
    init(info: String,
                stationName: String,
                followers: Int,
                date: Date,
                frontImageURL: URL?,
                backgroundImageURL: URL?,
                postCount: Int? = 0,
                parentStationID: String?,
                isSubStation: Bool? = false,
                stationType: StationType) {
        self.info = info
        self.stationName = stationName
        self.followers = followers
        self.date = date
        self.frontImageURL = frontImageURL
        self.backgroundImageURL = backgroundImageURL
        self.postCount = postCount
        self.parentStationID = parentStationID
        self.isSubStation = isSubStation
        self.stationType = stationType
        
    }
}
