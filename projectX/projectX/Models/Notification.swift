//
//  NotificationModel.swift
//  projectX
//
//  Created by Kirill on 10/11/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import Foundation

import FirebaseFirestore
import FirebaseFirestoreSwift

struct Notification : Identifiable, Codable{
    
    @DocumentID var id: String?

    var image: String
    var preview: String
    var timestamp: String

    init(image: String,
         body: String,
         timestamp: String) {

        self.image = image
        self.preview = body
        self.timestamp = timestamp
    }
}
