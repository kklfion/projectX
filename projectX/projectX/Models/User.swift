//
//  User.swift
//  projectX
//
//  Created by Radomyr Bezghin on 9/10/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//
import FirebaseFirestore
import FirebaseFirestoreSwift
struct User: Identifiable, Codable, Hashable {
    /// property wrapper that stores id of the document associated with data
    @DocumentID var id: String?
    
    /// The ID of the user. This corresponds with a Firebase user's uid property.
    var userID: String

    /// The display name of the user. Users with unspecified display names are given a default name.
    var name: String

    /// A url to the user's profile photo. Users with unspecified profile pictures are given a
    /// default profile picture.
    var photoURL: URL
    
    /// An email that user used to register an account
    var email: String

    /// An optional title that user can earn for  ....
    var title: String?

    /// Optional title can be followed up by some special symbol: star, light bubble etc...
    /// that will be chosen from the set of given options
    var titleImage: String?
    
    /// Age of the user
    var age: Int?
    
    ///how many people follow this user
    var followersCount: Int


}
extension User{
    /// All users are stored by their userIDs for easier querying later.
    var documentID: String {
      return userID
    }
    /// Returns a new User, providing a default name and photoURL if passed nil or left unspecified.
    public init(name: String? = "User",
                photoURL: URL? = User.defaultImageURL,
                email: String,
                uid: String,
                followersCount: Int) {
        
        self.init(userID: uid,
                  name: name ?? "User",
                  photoURL: photoURL ?? User.defaultImageURL,
                  email: email,
                  followersCount: followersCount)
    }
}
//MARK: default data
extension User{
    static let defaultImageURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/defaultUserIcon.png?alt=media&token=2e6edb8e-ac03-47fb-b58c-31bd6f3598e8")!
}
