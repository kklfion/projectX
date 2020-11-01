//
//  UserModel.swift
//  projectX
//
//  Created by Jake Nations on 8/20/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//
import UIKit

struct UserModel{
    //To do: Add more assests like pictures, or fucking avatars
    
    var firstName: String
    var lastName: String
    var uid: String
    
    init(firstName: String,
         lastName: String,
         uid: String) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.uid = uid

    }
    
}

