//
//  FirebaseExtension.swift
//  projectX
//
//  Created by Radomyr Bezghin on 9/10/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import FirebaseFirestore

extension Firestore{
    ///Returns a reference to the top level collections
    var posts: CollectionReference{
        return self.collection("posts")
    }
    ///Returns a reference to the top level collections
    var stations: CollectionReference{
        return self.collection("stations")
    }
    ///Returns a reference to the top level collections
    var comments: CollectionReference{
        return self.collection("comments")
    }
    ///Returns a reference to the top level collections
    var users: CollectionReference{
        return self.collection("users")
    }
    var boards: CollectionReference{
        return self.collection("missions")
    }
}
