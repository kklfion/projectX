//
//  additional.swift
//  projectX
//
//  Created by Radomyr Bezghin on 7/22/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import FirebaseFirestore

struct Data{
    static func fakeSomeData(){
        let post = Post(stationID: "123", stationName: "p", likes: 1, userInfo: User(), title: "k", text: "text", date: Date(), imageURL: nil)
        let db = Firestore.firestore()
        
        let batch = db.batch()
        batch.add(post: post)
        
        batch.commit { error in
          if let error = error {
            print("Error populating Firestore: \(error)")
          } else {
            print("Batch committed!")
          }
        }
    }
}

struct  FakePostData{
    func giveMeSomeData() -> [PostModel]{
        var Data = [PostModel]()
        
        var image = UIImage(named: "ucsc")
        Data.append(PostModel(image: image, title: "Will we be having online classes for the whole school year?", body: "I decided to stay home for the fall quarter bc everything will be online but will... ", author: "Sammy", station: "UCSC", likesCount: 17, commentsCount: 13))
        image = UIImage(named: "airpods")
        Data.append(PostModel(image: image, title: "Community college improves graduation rate", body: "Study: Students Who Take Some Courses At Community Colleges Increase Their Chances Of Earning A Bachelor’s Degree", author: "Sammy", station: "UCSC", likesCount: 12, commentsCount: 51))
        Data.append(PostModel(image: nil, title: "Zoom Settings", body: "", author: "Sammy", station: "UCSC", likesCount: 6, commentsCount: 2))
        Data.append(PostModel(image: nil, title: "UCSC 2020-21 Freshman Acceptance Rate is 65.25%", body: "some body text I ran out of ideas I ran out of ideas I ran out of ideas I ran out of ideas I ran out of ideas ", author: "Sammy", station: "UCSC", likesCount: 12, commentsCount: 13))
        Data.append(PostModel(image: nil, title: "I ran out of ideas", body: "some body text", author: "Sammy", station: "UCSC", likesCount: 12, commentsCount: 13 ))
        Data.append(PostModel(image: nil, title: "I ran out of ideas", body: "some body text", author: "Sammy", station: "UCSC", likesCount: 12, commentsCount: 13 ))
        Data.append(PostModel(image: nil, title: "I ran out of ideas ", body: "some body text I ran out of ideas I ran out of ideas I ran out of ideas I ran out of ideas I ran out of ideas", author: "Sammy", station: "UCSC", likesCount: 12, commentsCount: 13))
        Data.append(PostModel(image: nil, title: "I ran out of ideas", body: "some body text", author: "Sammy", station: "UCSC", likesCount: 12, commentsCount: 13))
        
        return Data
    }
    
    
    
}
