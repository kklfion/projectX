//
//  Constants.swift
//  projectX
//
//  Created by Radomyr Bezghin on 7/22/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit
struct Constants{
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
        static let mainTextFontSize: CGFloat = 16
        static let otherTextFontSize: CGFloat = 13
        static let logoFontSize: CGFloat = 20
        //paddings
        static let stackViewLeftRightPadding: CGFloat = 60
        static let padding: CGFloat = 10
        static let bottomStackViewTopPadding: CGFloat = 100
    }
}
