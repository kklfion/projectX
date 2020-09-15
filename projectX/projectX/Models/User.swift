//
//  User.swift
//  projectX
//
//  Created by Radomyr Bezghin on 9/10/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//
import FirebaseFirestore
import FirebaseFirestoreSwift
struct User: Codable {
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
}
extension User{
    /// All users are stored by their userIDs for easier querying later.
    var documentID: String {
      return userID
    }
    /// Returns a new User, providing a default name and photoURL if passed nil or left unspecified.
    public init(name: String? = "User",
                photoURL: URL? = User.defaultImageURL,
                email: String) {
        let uid = UUID().uuidString
        self.init(userID: uid,
                  name: name ?? "User",
                  photoURL: photoURL ?? User.defaultImageURL,
                  email: email)
    }
}
//MARK: default data
extension User{
    static let defaultImageURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/sslug.jpg?alt=media&token=aa2bda56-f5bc-4cc5-b9a2-ca37a6b4b7ae")!
}
