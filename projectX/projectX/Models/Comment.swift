//
//  CommentModel.swift
//  projectX
//
//  Created by Radomyr Bezghin on 9/10/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Comment: Identifiable, Codable, Hashable{
    /// property wrapper that stores id of the document associated with data
    @DocumentID var id: String?

    /// post where comment is posted.
    var postID: String

    /// The number of likes of the post.
    var likes: Int

    /// User information duplicated in the comment object.
    var userID: String
    
    /// The body text of the comment.
    var text: String

    /// The date the comment was posted.
    var date: Date
    
    /// If author of the comment wants to be Anonymous
    var isAnonymous: Bool?
    
    // MARK: - Hashable conformance
    static func == (lhs: Comment, rhs: Comment) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}
extension Comment{
    public init(postID: String,
                userID: String,
                text: String,
                likes: Int,
                date: Date,
                isAnonymous: Bool? = false) {
        self.postID = postID
        self.userID = userID
        self.text = text
        self.likes = likes
        self.date = date
        self.isAnonymous = isAnonymous
    }
}
