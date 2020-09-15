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
    var followers: Int

    /// The date when station was created.
    var date: Date
    
    /// Station photo url stored in the Firestore
    var imageURL: URL?
}
extension Station{
    init(info: String,
                stationName: String,
                followers: Int,
                date: Date,
                imageURL: URL?) {
        self.info = info
        self.stationName = stationName
        self.followers = followers
        self.date = date
        self.imageURL = imageURL
    }
}
