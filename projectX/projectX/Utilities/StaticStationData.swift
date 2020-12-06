//
//  StaticData.swift
//  projectX
//
//  Created by Radomyr Bezghin on 12/5/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import Foundation

struct StaticStationData{
    
    
    static func writeStations(){
        var stations = [Station]()
        let names  = StaticStationData.stationNames
        let info = StaticStationData.stationInfo
        let images = StaticStationData.stationImages
        for ( index, _) in names.enumerated() {
            let station = Station(info: info[index],
                                  stationName: names[index],
                                  followers: 0,
                                  date: Date(),
                                  frontImageURL: nil,
                                  backgroundImageURL: URL(string: images[index]),
                                  postCount: 0,
                                  parentStationID: nil,
                                  isSubStation: false,
                                  stationType: .station)
            stations.append(station)
        }
        
        NetworkManager.shared.writeDocumentsWith(collectionType: .stations, documents: stations) { (error) in
            print(error)
        }
    }

    static let stationNames =
        [
        "Anime", "News", "Celebrity", "Gaming", "Pets", "Astrology", "Netflix & Chill", "Relationship"
        ]
    static let stationInfo =
        [
        "Anime Station provides a space for you to share light novels, anime discussions/recommendations, cosplay, fanfiction, and anime drawings. You’re also encouraged to share news about upcoming anime series and conventions.",
        "News Station welcomes respectful discussion on your view of contemporary political climate, domestic and international policy, and trending topics.",
        "Celebrity Station provides a place for discussion, question, interaction, and sharing related to celebrity and influencers. Discuss and share the most recent news and pictures of your celebrities. ",
        "Gaming Station provides a space for critiquing game strategy, sharing stream/game recommendations, showcasing gameplay, and forming a college friend group to play games with.",
        "Pet Station is a place where you show off your lovely pet and for discussion/support on concerns about your pet.  ",
        "Astrology Station provides a space for signs compatibility, signs meaning, sign personality trait, and tarot reading. For you to explore and discover the mystery of birth time and the universe. ",
        "Netflix & Chill Station provides a space for everyone to share and discuss about sex, sexual education, stigmas, and sex-related conversation. ",
        "Relationship station provides a space for family, friends, and lovers to unite and to discuss relationship problems."
        ]
    static let stationImages =
        [
            "https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/stationsImages%2FAnime%20station.jpg?alt=media&token=5dadfc2f-dcb1-42c0-bdb6-a5a4774d3485",
            "https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/stationsImages%2FNews%20station.jpg?alt=media&token=4ac80489-eea6-4fca-89d6-d5f42c4c2886",
            "https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/stationsImages%2FCelebrity%20stations.jpg?alt=media&token=b95a2fd8-ca81-473f-92ea-cb023384af82",
            "https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/stationsImages%2FVideo%20game%20station.jpg?alt=media&token=9237e6d7-2aa4-4c81-921e-f108f4d5800b",
            "https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/stationsImages%2FPet%20station.jpg?alt=media&token=d607e95f-880f-47ca-9b37-da45258a46f2",
            "https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/stationsImages%2FAstrology%20station.jpg?alt=media&token=7756f8e9-51c2-47ca-a6ca-f551f686448d",
            "https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/stationsImages%2FNetflix%20and%20chill%20station.jpg?alt=media&token=7c89246a-a98c-4e74-b4a3-2f2ce29de210",
            "https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/stationsImages%2FRelationship%20Station.jpg?alt=media&token=442b10ad-4cea-426d-8791-8770d5f73bdf"
        ]
    
}

