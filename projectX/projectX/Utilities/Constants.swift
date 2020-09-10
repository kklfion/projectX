//
//  Constants.swift
//  projectX
//
//  Created by Radomyr Bezghin on 7/22/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit
struct Constants{
    
    static let PostCellID = "regularPostCell"
    
    static let mainTextFontSize: CGFloat = 14
    static let smallTextFontSize: CGFloat = 12
    static let standardPadding: CGFloat = 10
   
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
        static let logoFontSize: CGFloat = 20
        //paddings
        static let stackViewLeftRightPadding: CGFloat = 60
        static let padding: CGFloat = 10
        static let bottomStackViewTopPadding: CGFloat = 100
    }
    struct Home {
        static let layerBorderWidth: CGFloat = 0.5
        static let cornerRadius: CGFloat = 4

    }
}
    