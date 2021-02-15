//
//  StationsView.swift
//  projectX
//
//  Created by Radomyr Bezghin on 8/2/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//
class ShadowButton: UIButton {
    
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

import UIKit
/// use init(frame: CGRect, type: TypeOfStation) and specify what type of station it is! Depending on that different tableViews will be displayed
class StationView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    let backgroundView: UIView = {
        let view = UIView()
        return view
    }()
    let roundedView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.mainBackground
        return view
    }()
    let frontImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    let stationNameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.headlineTextFont
        label.numberOfLines = 1
        return label
    }()
    let followersLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Constants.bodyTextFont
        return label
    }()
    let followButton: ShadowButton = {
        let button = ShadowButton()
        button.backgroundColor = Constants.Colors.secondaryBackground
        return button
    }()
    let stationInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.font = Constants.bodyTextFont
        return label
    }()
}
//MARK: view setup
extension StationView{
    
    func setupViews(){
        self.backgroundColor = .none
        let roundedViewCornerRadius: CGFloat = 25
        [backgroundView, frontImageView, followersLabel,stationInfoLabel,stationNameLabel,followButton, roundedView].forEach({self.addSubview($0)})
        backgroundView.addAnchors(top: self.topAnchor,
                                       leading: self.leadingAnchor,
                                       bottom: roundedView.topAnchor,
                                       trailing: self.trailingAnchor,
                                       padding: .init(top: 0, left: 0, bottom: -roundedViewCornerRadius, right: 0))
        //organize views order
        self.sendSubviewToBack(roundedView)
        self.sendSubviewToBack(backgroundView)
        self.bringSubviewToFront(followButton)
        
        roundedView.layer.cornerRadius = roundedViewCornerRadius
        roundedView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        roundedView.addAnchors(top: nil,
                                       leading: self.leadingAnchor,
                                       bottom: self.bottomAnchor,
                                       trailing: self.trailingAnchor,
                                       size: .init(width: 0, height: (self.frame.height * 0.5)))
        roundedView.layoutIfNeeded()
        roundedView.applyShadowWithCorner(containerView: roundedView, cornerRadious: roundedViewCornerRadius)
        let frontImageHeight: CGFloat = self.frame.height * 0.35
        frontImageView.addAnchors(top: nil,
                                  leading: self.leadingAnchor,
                                  bottom: nil,
                                  trailing: nil,
                                  padding: .init(top: 0, left: 15, bottom: 0, right: 0),
                                  size: .init(width: frontImageHeight, height: frontImageHeight))
        frontImageView.centerYAnchor.constraint(equalTo: roundedView.topAnchor, constant: 0).isActive = true
        
        stationNameLabel.addAnchors(top: nil,
                                    leading: frontImageView.trailingAnchor,
                                    bottom: roundedView.topAnchor,
                                    trailing: nil,
                                    padding: .init(top: 0, left: 10, bottom: 5, right: 0))
        followersLabel.addAnchors(top: roundedView.topAnchor,
                                  leading: stationNameLabel.leadingAnchor,
                                  bottom: nil,
                                  trailing: nil,
                                  padding: .init(top: 5, left: 0, bottom: 0, right: 0))
        stationInfoLabel.addAnchors(top: frontImageView.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: self.bottomAnchor,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 0, left: 25, bottom: 0, right: 25))
        let followButtonDimensions = self.frame.height * 0.15
        followButton.addAnchors(top: nil,
                                leading: nil,
                                bottom: nil,
                                trailing: self.trailingAnchor,
                                padding: .init(top: 0, left: 0, bottom: 0, right: 30),
                                size: .init(width: followButtonDimensions, height: followButtonDimensions))
        followButton.centerYAnchor.constraint(equalTo: roundedView.topAnchor).isActive = true
        followButton.addSubview(RoundShadowView(frame: followButton.frame, cornerRadius: followButtonDimensions/2))
    }

    func setupGradient(mainColorHex: String, secondaryColorHex: String){
        layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        // Diagonal: top left to bottom corner.
        gradientLayer.startPoint = CGPoint(x: 0, y: 0) // Top left corner.
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        // Set the size of the layer to be equal to size of the display.
        gradientLayer.frame = backgroundView.bounds
        // Set an array of Core Graphics colors (.cgColor) to create the gradient.
        // This example uses a Color Literal and a UIColor from RGB values.29, 191, 143
        //let mainColor = UIColor(hex: mainColorHex)
        //let secondary = UIColor(hex: secondaryColorHex)
        let main = hexStringToUIColor(hex: mainColorHex)
        let secondary = hexStringToUIColor(hex: secondaryColorHex)
        
        
        gradientLayer.colors = [secondary.cgColor, main.cgColor]
        // Rasterize this static layer to improve app performance.
        gradientLayer.shouldRasterize = true
        // Apply the gradient to the backgroundGradientView.
        backgroundView.layer.addSublayer(gradientLayer)
    }
}
//MARK: helper functions
extension StationView {
    func setFollowButtonToFollowed(){
        followButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
    }
    func setFollowButtonToNotFollowed(){
        followButton.setImage(UIImage(systemName: "plus"), for: .normal)
    }
    func notFollowedButton(){
        followButton.setImage(UIImage(systemName: "plus"), for: .normal)
    }
    func followedButton(){
        followButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
    }
    func changeFollowerCount(by number: Int){
        if number >= 1000{
            followersLabel.text = "\(number/1000)k Followers"
        }else{
            followersLabel.text = "\(number) Followers"
        }

    }
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
