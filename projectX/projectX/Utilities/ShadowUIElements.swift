//
//  ShadowUIElements.swift
//  projectX
//
//  Created by Radomyr Bezghin on 3/1/21.
//  Copyright © 2021 Radomyr Bezghin. All rights reserved.
//

import UIKit

class ShadowUICollectionViewCell: UICollectionViewCell{
    let cornerRadius: CGFloat = 10
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShadow()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        // Improve scrolling performance with an explicit shadowPath
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: cornerRadius
        ).cgPath
    }
    private func setupShadow(){
        // Apply rounded corners to contentView
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
        
        // Set masks to bounds to false to avoid the shadow
        // from being clipped to the corner radius
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        
        // Apply a shadow
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
}
class ShadowRoundUIButton: UIButton {
    
    let followedImage = UIImage(systemName: "checkmark", withConfiguration: Constants.sfSymbolsSetup.followButtonConfig)?.withTintColor(Constants.sfSymbolsSetup.followButtonColor, renderingMode: .alwaysOriginal)
    let notFollowedImage = UIImage(systemName: "plus", withConfiguration: Constants.sfSymbolsSetup.followButtonConfig)?.withTintColor(Constants.sfSymbolsSetup.followButtonColor, renderingMode: .alwaysOriginal)
    
    required init() {
        super.init(frame: .zero)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let halfOfButtonHeight = layer.frame.height / 2
        // setup shadow
        layer.cornerRadius = halfOfButtonHeight
        layer.shadowColor = Constants.Colors.shadow.cgColor
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: halfOfButtonHeight).cgPath
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 4.0
    }
}
