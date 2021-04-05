//
//  Post.swift
//  projectX
//
//  Created by Radomyr Bezghin on 9/10/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Post:Identifiable, Codable, Hashable{
    /// property wrapper that stores id of the document associated with data
    @DocumentID var id: String?

    /// station where post is posted.
    var stationID: String

    /// The name of the station.
    var stationName: String

    /// The number of likes of the post.
    var likes: Int
    
    //The number of comments
    var commentCount: Int

    /// User information duplicated in the post object.
    var userInfo: User

    /// The title of the post.
    var title: String
    
    /// The body text of the post.
    var text: String?

    /// The date the review was posted.
    var date: Date
    
    /// Post photo url stored in the Firestore
    var imageURLArray: [URL]?
    
    /// If user wants his name to be anoynmous
    var isAnonymous: Bool
    
    // MARK: - Hashable conformance
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
extension Post{
    /// returns a new post object 
    public init(stationID: String,
                stationName: String,
                likes: Int,
                userInfo: User,
                title: String,
                text: String?,
                date: Date,
                imageURLArray: [URL]?,
                commentCount: Int,
                isAnonymous: Bool = false) {
        if text != nil && text != Constants.NewPost.placeholderBodyText
        {
            self.text = text
        }
        self.stationID = stationID
        self.stationName = stationName
        self.likes = likes
        self.userInfo = userInfo
        self.title = title
        self.date = date
        self.imageURLArray = imageURLArray
        self.commentCount = commentCount
        self.isAnonymous = isAnonymous
    }
}
    
