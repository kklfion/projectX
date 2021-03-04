//
//  PostViewModel.swift
//  projectX
//
//  Created by Radomyr Bezghin on 3/3/21.
//  Copyright © 2021 Radomyr Bezghin. All rights reserved.
//

import UIKit

struct PostViewModel: Hashable{
    
    var post: Post
    
    var postImage: UIImage?
    
    var user: User
    
    var userImage: UIImage?
    
    var like: Like?
    
    init(post: Post, postImage: UIImage?, user: User, userImage: UIImage?, like: Like?) {
        self.postImage = postImage
        self.userImage = userImage
        self.post = post
        self.user = user
        self.like = like
    }
    func isAnonymous() -> Bool{
        return post.isAnonymous
    }
    func isLiked() -> Bool {
        return like != nil
    }
    func getLikesCountString() -> String{
        return String(post.likes)
    }
    func getCommentsCountString() -> String{
        return String(post.commentCount)
    }
    func getDate() -> String{
        let dateString = post.date.diff()
        return "\(dateString)"
    }
}
