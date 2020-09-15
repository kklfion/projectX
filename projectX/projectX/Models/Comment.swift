//
//  CommentModel.swift
//  projectX
//
//  Created by Radomyr Bezghin on 9/10/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//
import FirebaseFirestore
import FirebaseFirestoreSwift
struct Comment: Identifiable, Codable{
    /// property wrapper that stores id of the document associated with data
    @DocumentID var id: String?

    /// post where comment is posted.
    var postID: String

    /// The number of likes of the post.
    var likes: Int

    /// User information duplicated in the comment object.
    var userInfo: User
    
    /// The body text of the comment.
    var text: String

    /// The date the comment was posted.
    var date: Date

}
extension Comment{
    public init(postID: String,
                userInfo: User,
                text: String,
                likes: Int,
                date: Date) {
        self.postID = postID
        self.userInfo = userInfo
        self.text = text
        self.likes = likes
        self.date = date
    }
}
