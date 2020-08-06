//
//  additional.swift
//  projectX
//
//  Created by Radomyr Bezghin on 7/22/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

struct  FakePostData{
    func giveMeSomeData() -> [PostModel]{
        var Data = [PostModel]()
        
        var image = UIImage(named: "ucsc")
        Data.append(PostModel(image: image, title: "Will we be having online classes for the whole school year?", preview: "I decided to stay home for the fall quarter bc everything will be online but will... ", author: "Sammy", likesCount: 17, commentsCount: 13, postID: "1"))
        image = UIImage(named: "airpods")
        Data.append(PostModel(image: image, title: "Community college improves graduation rate", preview: "Study: Students Who Take Some Courses At Community Colleges Increase Their Chances Of Earning A Bachelor’s Degree", author: "Sammy", likesCount: 12, commentsCount: 511, postID: "2"))
        Data.append(PostModel(image: nil, title: "Zoom Settings", preview: "", author: "Sammy", likesCount: 6, commentsCount: 2, postID: "3"))
        Data.append(PostModel(image: nil, title: "UCSC 2020-21 Freshman Acceptance Rate is 65.25%", preview: "some preview text I ran out of ideas I ran out of ideas I ran out of ideas I ran out of ideas I ran out of ideas ", author: "Sammy", likesCount: 12, commentsCount: 13, postID: "4"))
        Data.append(PostModel(image: nil, title: "I ran out of ideas", preview: "some preview text", author: "Sammy", likesCount: 12, commentsCount: 13, postID: "5"))
        Data.append(PostModel(image: nil, title: "I ran out of ideas", preview: "some preview text", author: "Sammy", likesCount: 12, commentsCount: 13, postID: "6"))
        Data.append(PostModel(image: nil, title: "I ran out of ideas ", preview: "some preview text I ran out of ideas I ran out of ideas I ran out of ideas I ran out of ideas I ran out of ideas", author: "Sammy", likesCount: 12, commentsCount: 13, postID: "7"))
        Data.append(PostModel(image: nil, title: "I ran out of ideas", preview: "some preview text", author: "Sammy", likesCount: 12, commentsCount: 13, postID: "8"))
        
        return Data
    }
    
    
}
