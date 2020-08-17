//
//  PostModel.swift
//  projectX
//
//  Created by Radomyr Bezghin on 7/9/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

struct PostModel{
    
    var image: UIImage?
    var title: String
    var preview: String
    var author: String
    var likesCount: Int
    var commentsCount: Int
    var station: String
    var timestamp: Date
    
    init(image: UIImage?,
         title: String,
         body: String,
         author: String,
         station: String,
         timestamp: Date = Date(), //current date as default
         likesCount: Int = 0,
         commentsCount: Int = 0) {
        
        self.image = image
        self.title = title
        self.preview = body
        self.author = author
        self.likesCount = likesCount
        self.commentsCount = commentsCount
        self.station = station
        self.timestamp = timestamp

    }
    
}
