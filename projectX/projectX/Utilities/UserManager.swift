//
//  UserData.swift
//  projectX
//
//  Created by Radomyr Bezghin on 10/3/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import Foundation
import Firebase
/// keeps used data in sync across the app
class UserManager{
    static let shared = UserManager()
    let networkManager = NetworkManager.shared
    
    var userID: String?{
        didSet{
            guard let id = userID else {return}
            networkManager.getDataForUser(id) { (user, error) in
                if error != nil{
                    print("error")
                }else{
                    print("user was successfully set")
                    self.userData = user
                }
            }
        }
    }
    var userData: User? = nil
    
    func defaultUser()-> User{
        return User(name: "", photoURL: nil, email: "", uid: "")
    }
    func signMeOut(){
        do{
            try Auth.auth().signOut()
            userData = defaultUser()
            userID = ""
            print("Success signing out")
        }catch let error{
            print("error signing out: \(error)")
        }
    }
    func deleteMe(){
        print("Deleting disabled")
//        let user = Auth.auth().currentUser
//
//        user?.delete { error in
//            if let error = error {
//                print("Error deleting account \(error)")
//            } else {
//                print("Account was successfully deleted!")
//            }
//        }
    }
    
    
}
