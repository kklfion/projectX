//
//  UserData.swift
//  projectX
//
//  Created by Radomyr Bezghin on 10/3/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import Foundation
import Firebase
import Combine

/// Users state in the app
enum UserState {
    
    ///when user was signedin, returns current user data
    case signedIn(user: User)
    
    ///deafault state
    case signedOut
    
    ///when user data is loading
    case loading

}

///UserManager stores all the data related to the signedin user and
///it keeps user data in sync across the app
class UserManager {
    
    ///runs initialization, can be created once
    private static var sharedUserManager = UserManager()
    
    ///adds a listener
    private init() {
        state = .loading
        _ = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // User is signed in
                self.loadDataFor(userID: user.uid)
            } else {
                //User is signed out
                self.state = .signedOut
                self.user = nil
            }
        }
    }
    ///subscribe to receive user updates
    var didResolveUserState: ((User?) -> Void)?
    
    ///users current state state
    private(set) var state: UserState = .signedOut
    
    ///user that is fetched from db after login user id is avilable
    private(set) var user: User? {
        didSet {
            didResolveUserState?(user)
        }
    }
    
    ///is set after user was initialized, probably wont be used
    private(set) var userImage: UIImage?
    
    ///stations that user follows
    private var followedStations = [FollowedStation]()
    

}
//MARK: helper functions
extension UserManager{
    
    ///returns static instance of the userManager
    class func shared() -> UserManager {
        return sharedUserManager
    }
    
    func getCurrentUserData() -> (User?, UIImage?, UserState){
        return (user, userImage, state)
    }
    
    ///empties the current user data
    func setUserToNil(){
        userImage = nil
        user = nil
    }
    
    ///returns optinal followedStation if stationID is in the followedStations
    func isStationFollowed(stationID: String) -> FollowedStation? {
        for followedStation in followedStations{
            if stationID == followedStation.stationID{
                return followedStation
            }
        }
        return nil
    }
    ///when new followed station is added (button tapped) followedStations must be updated to the array, and it is separately added to the db
    func addFollowedStation(followedStation: FollowedStation){
        followedStations.append(followedStation)
    }
    ///removes station that is unfollowed from current followedStations, it is separately removed from the db
    func removeFollowedStation(stationID: String){
        followedStations = followedStations.filter { $0.stationID != stationID }
    }
}
//MARK: networking
extension UserManager{
    
    ///function that manages loading data for user id
    private func loadDataFor(userID: String){
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let group = DispatchGroup()
            //1 load user data
            group.enter()
            self?.loadCurrentUser(withId: userID) {
                group.leave()
            }
            group.wait()
            //2 get image for user
            self?.loadUserImage()
            //3 fetch followed stations
            self?.fetchFollowedStations()
        }
        
    }

    ///after user is set tries loading the image
    private func loadUserImage(){
        guard let url = user?.photoURL else {return}
        NetworkManager.shared.getAsynchImage(withURL: url) { [weak self] (image, error) in
            if error != nil {
                print("error loading image")
            }
            else if image != nil {
                DispatchQueue.main.async {
                    self?.userImage = image
                }
            }
        }
    }
    ///uses the id of currently logged in used to get the data stored in the Firebstore
    /// user is either already signed in OR this function will be called after successful login
    private func loadCurrentUser(withId id: String, completion: @escaping () -> Void){
        NetworkManager.shared.getDataForUser(id) { [weak self] (user, error) in
            if error != nil{
                self?.state = .signedOut
                print("error getting user Data \(String(describing: error))")
                completion()
            }else{
                guard  let user = user else {return}
                self?.state = .signedIn(user: user)
                self?.user = user

                completion()
            }
        }
    }
    ///fetches stations that user follows
    private func fetchFollowedStations(){
        guard let userID = user?.userID else { print(UserError.userIsNil.localizedDescription);return}
        let query = NetworkManager.shared.db.followedStations.whereField(FirestoreFields.userID.rawValue, isEqualTo: userID)
        NetworkManager.shared.getDocumentsForQuery(query: query) { (followedStations: [FollowedStation]?, error) in
            if error != nil {
            }else if followedStations != nil {
                self.followedStations = followedStations!
            }else{
                print("No followed stations to load")
            }
        }
        
    }
    private func fetchUserFollowers(){
        
    }
    ///signs out current user and empties the user data
    func signOut(){
        do{
            try Auth.auth().signOut()
            print("Success signing out")
        }catch let error{
            print("error signing out: \(error)")
        }
    }
    ///deletes the current user from the database
    func deleteCurrentUser(){
        print("Deleting disabled")
        setUserToNil()
//        let user = Auth.auth().currentUser
//
//        user?.delete { error in
//            if let error = error {
//                print("Error deleting account \(error)")
//            } else {
//                userStatus = .loggedOff
//                print("Account was successfully deleted!")
//            }
//        }
    }

    
    
}

//MARK: combine code to user later
//not implemented! maybe not even needed
//public var userPublisher = CurrentValueSubject<User?, Never>(nil)
//    {
//        didSet{
//            userPublisher.send(user)
//        }
//    }
//        userSubscription = UserManager.shared.userPublisher.sink { (user) in
//            //print("received User in Profile test", user ?? "")
//        }
