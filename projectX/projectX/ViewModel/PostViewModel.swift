//
//  PostViewModel.swift
//  projectX
//
//  Created by Radomyr Bezghin on 3/3/21.
//  Copyright © 2021 Radomyr Bezghin. All rights reserved.
//

import UIKit

struct PostViewModel: Hashable{
    /// station where post is posted.
    var stationID: String

    /// The name of the station.
    var stationName: String

    /// The number of likes of the post.
    var likes: String
    
    //The number of comments
    var commentCount: String

    /// The title of the post.
    var title: String

    /// The date the review was posted.
    var date: String
    
    /// If user wants his name to be anoynmous
    var isAnonymous: Bool
    
    var post: Post
    
    var postImage: UIImage?
    
    var user: User
    
    var userImage: UIImage?
    
    var isLiked: Bool
    
    init(post: Post, postImage: UIImage?, user: User, userImage: UIImage?, like: Bool) {
        self.stationName = post.stationName
        self.stationID = post.stationID
        self.likes = String(post.likes)
        self.commentCount = String(post.commentCount)
        self.title = post.title
        let dateString = post.date.diff()
        self.date = "\(dateString)"
        self.isAnonymous = post.isAnonymous
        
        self.postImage = postImage
        self.userImage = userImage
        self.post = post
        self.user = user
        self.isLiked = like
    }
    
//    private func addData(toCell cell: PostCollectionViewCell, withPost post: Post ){
//        cell.titleLabel.text =  post.title
//        //cell.authorLabel.text =  post.userInfo.name
//        cell.likesLabel.text =  String(post.likes)
//        cell.commentsLabel.text =  String(post.commentCount)
//        cell.stationButton.setTitle(post.stationName, for: .normal)
//        let dateString = post.date.diff()
//        cell.dateLabel.text = "\(dateString)"
//        if !post.isAnonymous{
//            //cell.authorLabel.text =  post.userInfo.name
//            NetworkManager.shared.getAsynchImage(withURL: post.userInfo.photoURL) { (image, error) in
//                DispatchQueue.main.async {
//                    cell.authorImageView.image = image
//                }
//            }
//            cell.authorLabel.isUserInteractionEnabled = true
//            cell.authorImageView.isUserInteractionEnabled = true
//        } else{
//            cell.setAnonymousUser()
//        }
//        if post.imageURL != nil {
//            NetworkManager.shared.getAsynchImage(withURL: post.imageURL) { (image, error) in
//                DispatchQueue.main.async {
//                    cell.setPostImage(image: image)
//                }
//            }
//        } else{
//            cell.setDefaultPostImage()
//        }
//
//        if likesDictionary[post] != nil {
//            cell.isLiked = true
//        }else{
//            cell.isLiked = false
//        }
//    }
}
