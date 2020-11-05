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

///UserManager stores all the data related to the sighned in user and
///it keeps user data in sync across the app

enum UserState {
    
    ///when user was signedin, returns current user data
    case signedIn(user: User)
    
    ///when user is signed out
    case signedOut

}

class UserManager{
    
    static let shared = UserManager()

    ///creates an empty user
    private init(){
        user = nil
        userImage = nil
        state = .signedOut
    }
    
    ///when user is changed that data should be published to all the listening points
    private var user: User?

    ///is set after user was initialized
    private(set) var userImage: UIImage?
    ///users state
    private(set) var state: UserState
    
    func getCurrentUserData() -> (User?, UIImage?, UserState){
        return (user, userImage, state)
    }
    ///after user is set tries loading the image
    func loadUserImage(){
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
    func loadCurrentUser(withId id: String){
        NetworkManager.shared.getDataForUser(id) { [weak self] (user, error) in
            if error != nil{
                self?.state = .signedOut
                print("error getting user Data \(String(describing: error))")
            }else{
                guard  let user = user else {return}
                self?.state = .signedIn(user: user)
                self?.user = user
                self?.loadUserImage()
            }
        }
    }
    ///signs out current user and empties the user data
    func signOut(){
        do{
            try Auth.auth().signOut()
            state = .signedOut
            setUserToNil()
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
    ///empties the current user data
    func setUserToNil(){
        userImage = nil
        user = nil
    }
    ///returns empty user
    private func defaultUser()-> User{
        return User(name: "", photoURL: nil, email: "", uid: "")
    }
    
    
}

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
