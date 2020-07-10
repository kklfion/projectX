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
    var postID: String
    
    init(image: UIImage?, title: String, preview: String, author: String, likesCount: Int, commentsCount: Int, postID: String) {
        self.image = image
        self.title = title
        self.preview = preview
        self.author = author
        self.likesCount = likesCount
        self.commentsCount = commentsCount
        self.postID = postID
    }
}
