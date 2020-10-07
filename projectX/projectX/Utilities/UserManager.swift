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

enum UserStatus: String{
    case signedIn
    case loggedOff
    case invalid
}

///UserManager stores all the data related to the sighned in user and
///it keeps user data in sync across the app
class UserManager{
    
    static let shared = UserManager()
    let networkManager = NetworkManager.shared
    
    ///not sure if this works ..
//    var userDataPublisher: AnyPublisher<User, Never>{
//        subject.eraseToAnyPublisher()
//    }
//    private let subject = PassthroughSubject<User, Never>()
    
    ///when user is changed that data should be published to all the listening points
    private(set) var user: User? = nil{
        didSet{
            guard let user = user else {return}
            getUserImage()
            //subject.send(user)
        }
    }
    var userImage: UIImage? = nil
    private(set) var userStatus: UserStatus = .invalid
    ///after user is set tries loading the image
    func getUserImage(){
        guard let url = user?.photoURL else {return}
        networkManager.getAsynchImage(withURL: url) { [weak self] (image, error) in
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
    func setCurrentUser(withId id: String)->Void{
        networkManager.getDataForUser(id) { [weak self] (user, error) in
            if error != nil{
                print("error getting user Data \(error)")
            }else{
                self?.userStatus = .signedIn
                self?.user = user
            }
        }
    }
    ///empties the current user data
    func setDefaultUser(){
        userImage = nil
        user = defaultUser()
    }
    ///returns empty user
    func defaultUser()-> User{
        return User(name: "", photoURL: nil, email: "", uid: "")
    }
    ///signs out current user and empties the user data
    func signMeOut(){
        do{
            try Auth.auth().signOut()
            userStatus = .loggedOff
            setDefaultUser()
            print("Success signing out")
        }catch let error{
            print("error signing out: \(error)")
        }
    }
    ///deletes the current user from the database
    func deleteMe(){
        print("Deleting disabled")
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
