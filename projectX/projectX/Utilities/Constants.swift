//
//  Constants.swift
//  projectX
//
//  Created by Radomyr Bezghin on 7/22/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit
struct Constants{

    static let standardPadding: CGFloat = 10

    static let headlineTextFont = UIFont.preferredFont(forTextStyle: .headline)
    static let bodyTextFont = UIFont.preferredFont(forTextStyle: .subheadline)
    static let smallerTextFont = UIFont.preferredFont(forTextStyle: .footnote)

    struct defaultKeys{
        static let isExistingUserDefaultsKey = "isExistingUser"
    }
    
    struct sfSymbolsSetup{
        
        static let followButtonConfig = UIImage.SymbolConfiguration(pointSize: 17, weight: .heavy, scale: .large)
        static let followButtonColor = Constants.Colors.darkBrown
        
        static let likeCommentsConfig = UIImage.SymbolConfiguration(pointSize: 17, weight: .ultraLight, scale: .medium)
        static let likesCommentColor = Constants.Colors.buttonsRed
    }
    
    struct Colors {
        static let mainYellow = UIColor(named: "mainYellow") ?? UIColor.white//UIColor(rgb: 0xf6e58f)
        static let darkBrown = UIColor(named: "darkBrown") ?? UIColor(rgb: 0x434239)
        static let subText = UIColor(named: "subText") ?? UIColor(rgb: 0x817e6e)
        
        static let profileBlue = UIColor.systemBlue//UIColor(named: "profileBlue") ?? UIColor(rgb: 0xdff9ff)
        static let profileYellow = UIColor.systemYellow//UIColor(named: "profileYellow") ?? UIColor(rgb: 0xfef8d3)
        
        static let buttonsRed = UIColor(named: "buttonsRed") ?? UIColor(rgb: 0xf2aba7)
        static let shadow = UIColor(named: "shadow") ?? UIColor.lightGray
        static let gamingBackground = UIColor(named: "gamingBackground") ?? UIColor(rgb: 0x2A886D)

        static let placeholderTextColor = UIColor.lightGray
        static let mainText = Colors.darkBrown
        
        //
        static let mainBackground = UIColor(named: "mainBackground") ?? UIColor.white
        static let secondaryBackground = UIColor(named: "secondaryBackground") ?? UIColor.white//UIColor(rgb: 0xf6e58f)
        static let tertiaryBackground = UIColor(named: "tertiaryBackground") ?? UIColor.white
    }

    struct Screen {
        static let screenSize = UIScreen.main.bounds
        static let width = screenSize.width
        static let height = screenSize.height
        static let scale = UIScreen.main.scale
        static let bounds = UIScreen.main.bounds
        static let nativeBounds = UIScreen.main.nativeBounds
    }
    struct Login {
        //fonts
        static let mainTextFontSize: CGFloat = 14
        static let otherTextFontSize: CGFloat = 12
        static let logoFontSize: CGFloat = 24


        //paddings
        static let stackViewLeftRightPadding: CGFloat = 60
        static let padding: CGFloat = 10
        static let errorPadding: CGFloat = 5
        static let EmailPasswordStackViewTopPadding: CGFloat = 80
        static let loginSignUpStackViewTopPadding: CGFloat = 40
        static let logoPadding: CGFloat = 30
    }
    struct Home {
        static let layerBorderWidth: CGFloat = 0.5
        static let cornerRadius: CGFloat = 4

    }
    struct NewPost {
        static let placeholderTitleText = "Enter your title..."
        static let placeholderBodyText = "What are you thinking?"
    }
}
