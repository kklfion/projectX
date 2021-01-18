//
//  UserManagerEnums.swift
//  projectX
//
//  Created by Radomyr Bezghin on 11/5/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import Foundation

enum UserError: Error{
    
    case userIsNil
    
    case errorLoadingUser
    
}
extension UserError: LocalizedError{
    var errorDescription: String?{
        switch self {
        
        case .userIsNil:
            return NSLocalizedString("user hasnt been fetched", comment: "")
            
        case .errorLoadingUser:
            return NSLocalizedString("Error loading user", comment: "")
    
        }
    }
}

