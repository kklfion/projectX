//
//  additional.swift
//  projectX
//
//  Created by Radomyr Bezghin on 7/22/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import FirebaseFirestore
//MARK: POSTS
struct GetData {
    static func getUsers(completion: @escaping (_ users: [User]) -> Void){
        let basicQuery = Firestore.firestore().users
        var users = [User]()
        basicQuery.getDocuments { (snapshot, error) in
            if let error = error {
                print ("I got an error retrieving users: \(error)")
                return
            }
            guard let documents = snapshot?.documents else { return }
            users = documents.compactMap { (querySnapshot) -> User? in
                return try? querySnapshot.data(as: User.self)
            }
            completion(users)
        }
    }
    static func getStations(completion: @escaping (_ stations: [Station]) -> Void){
        let basicQuery = Firestore.firestore().stations
        var stations = [Station]()
        basicQuery.getDocuments { (snapshot, error) in
            if let error = error {
                print ("I got an error retrieving stations: \(error)")
                return
            }
            guard let documents = snapshot?.documents else { return }
            stations = documents.compactMap { (querySnapshot) -> Station? in
                return try? querySnapshot.data(as: Station.self)
            }
            completion(stations)
        }
    }
    static func getPosts(completion: @escaping (_ stations: [Post]) -> Void){
        let basicQuery = Firestore.firestore().posts
        var posts = [Post]()
        basicQuery.getDocuments { (snapshot, error) in
            if let error = error {
                print ("I got an error retrieving posts: \(error)")
                return
            }
            guard let documents = snapshot?.documents else { return }
            posts = documents.compactMap { (querySnapshot) -> Post? in
                return try? querySnapshot.data(as: Post.self)
            }
            completion(posts)
        }
    }
    static func getComments(completion: @escaping (_ stations: [Comment]) -> Void){
        let basicQuery = Firestore.firestore().comments
        var comments = [Comment]()
        basicQuery.getDocuments { (snapshot, error) in
            if let error = error {
                print ("I got an error retrieving comments: \(error)")
                return
            }
            guard let documents = snapshot?.documents else { return }
            comments = documents.compactMap { (querySnapshot) -> Comment? in
                return try? querySnapshot.data(as: Comment.self)
            }
            completion(comments)
        }
    }
}
struct CommentsData{
    static func createComments(){
        var users = [User]()
        var posts = [Post]()
        // get posts
        GetData.getPosts { (pst) in
            posts = pst
        }
        // get users
        GetData.getUsers { (usr) in
            users = usr
        }
        // create comments
        // send'em away to gulag
        //QUICK FIX , waiting for requests to be completed
        //TODO: this must be fixed
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let comments = createCommentsWith(users: users, posts: posts)
            sendComments(comments: comments)
        }
    }
    static func sendComments(comments: [Comment]){
        let db = Firestore.firestore()
        for comment in comments{
            do {
                let _ = try db.comments.addDocument(from: comment)
            }
            catch {
                    print(error)
            }
        }
    }
    static func createCommentsWith(users: [User], posts: [Post])-> [Comment]{
        var comments = [Comment]()
        for n in 1...50 {
            let post = posts.randomElement()!, user = users.randomElement()!
            let comment = Comment(postID: post.id ?? "",
                                  userInfo: user,
                                  text: text.randomElement()!,
                                  likes: n*4,
                                  date: Date())
            comments.append(comment)
        }
        for n in 1...50 {
            let post = posts.randomElement()!, user = users.randomElement()!
            let comment = Comment(postID: post.id ?? "",
                                  userInfo: user,
                                  text: text.randomElement()!,
                                  likes: n*3,
                                  date: Date())
            comments.append(comment)
        }
        comments.shuffle()
        return comments
    }
}
struct PostsData{
    static func createPosts(){
        //first I need to get statations data and some users
        var users = [User]()
        var stations = [Station]()
        GetData.getUsers { (usr) in
            users = usr
        }
        GetData.getStations(completion: { sts in
            stations = sts
        })
        //QUICK FIX , waiting for requests to be completed
        //TODO: this must be fixed
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let posts = createPostsWith(users: users, stations: stations)
            sendPosts(posts: posts)
        }
    }
    static func sendPosts(posts: [Post]){
        let db = Firestore.firestore()
        for post in posts{
            do {
                let _ = try db.posts.addDocument(from: post)
            }
            catch {
                    print(error)
            }
        }
    }
    static func createPostsWith(users: [User], stations: [Station])-> [Post]{
        var posts = [Post]()
        //for n in 1...12 {
            //let station = stations.randomElement(), user = users.randomElement()
            //let post = Post(stationID: station?.stationName ?? "",
                           // stationName: n*10,
                           // likes: user!, comments: 0,
                           // userInfo: titles.randomElement() ?? "",
                           // title: text.randomElement() ?? "",
                            //text: Date())
            //posts.append(post)
       // }
        for n in 1...10 {
            let station = stations.randomElement(), user = users.randomElement()
            let post = Post(stationID: station?.id ?? "",
                            stationName: station?.stationName ?? "",
                            likes: n*4,
                            userInfo: user!,
                            title: titles.randomElement() ?? "",
                            text: text.randomElement() ?? "",
                            date: Date(),
                            imageURL: postURLs.randomElement()!, commentCount: 0)
            posts.append(post)
        }
        posts.shuffle()
        return posts
    }
}
//MARK: USERS
struct UsersData {
    /// creates fake users
     static func createUsers(){
        let db = Firestore.firestore()
        var users = [User]()
        for email in emails{
            let name = (firstNames.randomElement() ?? "First name") + " " + (lastNames.randomElement() ?? "Last Name")
            let user = User(name: name, email: email, uid: "1234")
            users.append(user)
        }
        for user in users{
            do {
                //let _ = try db.users.addDocument(from: user)
                let _ = try db.users.document(user.documentID).setData(from: user)
            }
            catch {
                    print(error)
            }
        }
    }
}
//MARK: Stations
struct StationsData{
    /// creates UC colleges as  default stations
     static func createStations(){
        let db = Firestore.firestore()
        var stations = [Station]()
        for (college, collegeName) in colleges{
            let station = Station(info: infoDict[college]!,
                                  stationName: collegeName,
                                  followers: 0,
                                  date: Date(),
                                  frontImageURL: collegeLogoURLSDict[college]!,
                                  backgroundImageURL: collegeBackgroundPhotoURLSDict[college]!)
            stations.append(station)
        }
        for station in stations{
            do {
                let _ = try db.stations.addDocument(from: station)
            }
            catch {
                    print(error)
            }
        }
    }
}
struct DataTest{
    static func fakeSomeData(){
        let user = User(name: "NEW USER", email: "user@gmail.com", uid: "1234")
        _ = Post(stationID: "123141233123", stationName: "ucsc", likes: 12, userInfo: user, title: "Welcome to UCSC", text: "Best college ever", date: Date(), imageURL: URL(string:  "https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/sslug.jpg?alt=media&token=aa2bda56-f5bc-4cc5-b9a2-ca37a6b4b7ae")!, commentCount: 0)
        let db = Firestore.firestore()
        do {
            let _ = try db.collection("posts").addDocument(from: user)
            //let _ = try db.users.document(user.documentID).setData(from: user)
        }
        catch {
                print(error)
        }
    }
    static func readSomeData(){
        let basicQuery = Firestore.firestore().posts.limit(to: 10)
        basicQuery.getDocuments { (snapshot, error) in
            if let error = error {
                print ("I got an error retrieving posts: \(error)")
                return
            }
            guard let documents = snapshot?.documents else { return }
            let _ = documents.compactMap { (querySnapshot) -> Post? in
                return try? querySnapshot.data(as: Post.self)
            }
            //print(posts)
        }
    }
}
extension CommentsData{
    //let comment = Comment(postID: <#T##String#>, userInfo: <#T##User#>, text: <#T##String#>, likes: <#T##Int#>, date: <#T##Date#>)
    static let text = ["So do you feed him anything special or do anything to help extend his life?","He drinks from the showers","thank you","It’s been sitting in my random image folder on my phone for a long time, needed to share it somewhere", "Amazing. And we're here to witness it.","There's a guy who has had several cats that have lived to be older than 30, including the oldest cat in recorded history. No joke, once a week he gives them a tiny bit of red wine. There are scientists studying his cats and his methods for caring for them to figure out if that's actually doing something. They're not encouraging people start giving their cats wine just yet though.", "He also turned his garage into a cat playroom which has a projector that shows wildlife documentaries which he says keeps their minds active.", "The guy also has a water fountain for the cats, something everyone can do. Cats hate standing water, and will instinctively find other water sources, including toilets or showers. Put a bowl of water in front of a cat and it will drink it if absolutely necessary, but run a tap or a fountain and most are pretty eager to have a drink.", "He could possibly be the oldest cat in the world", "Yeh, had to let my cat go last year who was 24. Thought that that was rare already.", "My oldest one to date has been 22. She developed dementia in her last year of life and thought she was a kitten so she was pretty active and chirping.","sounds like pet dementia is a good thingI mean it's lacking pretty much all the tragic aspects of human dementia edit: apparently that's not the case, sorry to all pet owners who have or had to deal with it", "ots of documented people have reached 110-115 years of age. 122 isn’t an insane outlier. True or not. Some dude having two cats get close to 40 with the oldest well documented cats being 31 or so is a lot harder to believe", "Truth. I never realized how many centenarians are quietly living on out there until I started working in a hospital in a wealthy retirement town. I've met more people over the age of 100 in the last 4 years than I ever thought existed. Pretty cool.", "Wait whaaat", "The theory is that the real Jeanne Calment died and her daughter assumed her identity in order to dodge inheritance taxes.","Imagine lying about this to dodge tax, and then years later you have to keep the lie up to the press because they think you're the oldest person ever.", "I love that you qualified that with “not literally.” Reminds me of “I’m my own grandpa” lol"]
}
extension UsersData{
    static let firstNames = ["Sophia", "Jackson", "Olivia", "Liam", "Emma", "Noah", "Ava", "Aiden",
                              "Isabella", "Lucas", "Mia", "Caden", "Aria", "Grayson", "Riley", "Mason"]

    static let lastNames = ["Smith", "Johnson", "Williams", "Jones", "Brown", "Davis", "Miller", "Wilson",
                            "Moore", "Taylor", "Anderson", "Thomas", "Jackson", "White", "Harris", "Martin",
                            "Thompson", "Garcia", "Martinez", "Robinson", "Clark", "Rodriguez", "Lewis", "Lee"]
    static let emails =
        [
        "miturria@outlook.com", "martink@outlook.com", "mwandel@msn.com", "dhrakar@icloud.com", "maradine@msn.com", "wiseb@me.com", "campware@att.net", "carroll@att.net", "fbriere@yahoo.ca", "matthijs@outlook.com", "stefano@live.com", "webinc@yahoo.com"
        ]
}
extension StationsData{
    //let colleges = ["UC Berkeley", "UC Davis", "UC Irvine", "UCLA", "UC Merced", "UC Riverside", "UC San Diego", "UC San Francisco", "UC Santa Barbara", "UC Santa Cruz"]
    static let colleges = ["ucla": "UCLA","ucsc": "UC Santa Cruz"]
    static let collegeLogoURLSDict =
        [
        "ucsc": URL(string:"https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/ucsclogo.png?alt=media&token=1a1f296d-c8f8-4aad-86b6-25f5c4398246"),
        "ucla": URL(string:"https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/uclalogo.jpg?alt=media&token=78f8d3d4-7ac7-4475-8da6-0284e169c149")
        ]
    static let collegeBackgroundPhotoURLSDict =
        [
        "ucsc": URL(string: "https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/ucscbackground.jpg?alt=media&token=c030c5df-eb6d-4c1c-a85a-6faa2142b65d"),
        "ucla": URL(string:"https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/uclabackground.jpg?alt=media&token=aa670aa1-2a82-4b9d-a932-84e9ea6225cf")
        ]
    static let infoDict =
        [
            "ucsc":"The University of California, Santa Cruz is a public research university in Santa Cruz, California. It is one of 10 campuses in the University of California system.",
            "ucla": "The University of California, Los Angeles is a public research university in Los Angeles, California. UCLA traces its early origins back to 1882 as the southern branch of the California State Normal School."
        ]
}
extension PostsData{
    //let post = Post(stationID: <#T##String#>, stationName: <#T##String#>, likes: <#T##Int#>, userInfo: <#T##User#>, title: <#T##String#>, text: <#T##String#>, date: <#T##Date#>, imageURL: <#T##URL?#>)
    static let titles = ["How to display a number of symbols according to an integer", "iOS 14 Releasing Tomorrow!", "I made a chat app to make programmer friends using SwiftUI !", "Any update on grad students waiting on Financial Aid?", "ARCore"]
    static let text = ["Do you guys recommend ARCore for webAR? Could I import blender animations into it? Thanks :)", "I had called financial aid months ago because I knew I was going to have to use portion of loans for my first year and they had told me I would get a package in late August early September. As an out of state student, I saw that I had gotten a fellowship that basically was meant to cover my out of state tuition fees, thats all, there was nothing else. I called FA again and they stated I would have to apply to the grad plus loan... that was it. I wasn't happy with this answer because it didn't make any sense, so I called again and a different person told me the grad packages haven't been sent out yet. So basically I just want to know if other grads have gotten their packages yet, and if not, have they also told you we wouldn't get it until next week.",
        """
        Hello everybody!
        I just published an iOS app named csBuddies (link at the bottom), and it's perfect for you to make friends who are programmers.

        Using a comprehensive filtering system, you can easily discover like-minded coders who share similar interests as you.
        And after finding programmers you'd like to chat, you can simply text them to start a conversation.
        If you wish to make programmer friends, discuss fun coding projects, or simply talk about computer science in general, then csBuddies is the community for you!

        I designed this chat app using SwiftUI, and I'm definitely planning to update it continuously as I take into account all of your feedback.
        Thank you so much for reading, and please feel free to comment here or email me at csbuddiesapp@gmail.com for any kind of feedback!
        And lastly, remember to stay safe during this global pandemic!

        Link to the app on App Store:
        https://apps.apple.com/app/id1524982759
        """,
        """
        Hi r/HackingWithSwift
        Sorry if this question is stupid. I am new to programming in general, not just Swift.
        I would like to put this (mockup) in my project with SwiftUI. It is like how Zelda BotW shows HP. 1 value with a small symbol, 1 unit of values (4 or 5) is shown with a big symbol.
        The number would get to 3 digits so I can't really do it one by one. I tried text view and array but they can't parse SF symbols/images. HStack won't return a new line. It hasn't even got to the big and small icon thing and I am already out of my depth.
        Any advice or pointers appreciated.
        """
        , ""
    ]
    static let postURLs =
        [
        URL(string:"https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/fakePostImages%2FrandomPostImage.jpg?alt=media&token=325ae3ef-e426-415b-9273-c642b35e3cfd"),
        URL(string:"https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/fakePostImages%2Frandompostimage2.jpg?alt=media&token=3ae0c1a3-31d3-4032-8097-4e35d0e82c23"),
        URL(string:"https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/fakePostImages%2Frandompostimage3.jpg?alt=media&token=838315e5-66ee-421b-af90-62c6b63f96f3")
    ]
}


struct  FakePostData{
    func giveMeSomeData(completion: @escaping (_ stations: [Post]) -> Void){
        
        var db: Firestore!
        db = Firestore.firestore()
        
        let basicQuery = db.collection("posts").limit(to: 5)
       var posts = [Post]()
       basicQuery.getDocuments { (snapshot, error) in
        if let snapshotDocuments = snapshot?.documents {
            for document in snapshotDocuments{
                do{
                    if let post = try document.data(as: Post.self){
                        print(post.userInfo.name)
                        posts.append(post)
                    }
                } catch let error as NSError{
                    print("error: \(error.localizedDescription)")
                }
            }
        }
      }
        completion(posts)
    }
    
    
    
    
}
