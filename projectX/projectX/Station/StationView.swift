//
//  StationsView.swift
//  projectX
//
//  Created by Radomyr Bezghin on 8/2/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

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
    let roundedView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    let frontImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
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
    let followButton: UIButton = {
        let button = UIButton()
        button.setTitle("Follow", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.contentEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    let stationInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = Constants.bodyTextFont
        return label
    }()
}
//MARK: view setup
extension StationView{
    
    func setupViews(){
        self.backgroundColor = .none
        let roundedViewCornerRadius: CGFloat = 25
        [backgroundImageView, frontImageView, followersLabel,stationInfoLabel,stationNameLabel,followButton, roundedView].forEach({self.addSubview($0)})
        backgroundImageView.addAnchors(top: self.topAnchor,
                                       leading: self.leadingAnchor,
                                       bottom: roundedView.topAnchor,
                                       trailing: self.trailingAnchor,
                                       padding: .init(top: 0, left: 0, bottom: -roundedViewCornerRadius, right: 0))
        //organize views order
        self.sendSubviewToBack(roundedView)
        self.sendSubviewToBack(backgroundImageView)
        
        roundedView.layer.cornerRadius = roundedViewCornerRadius
        roundedView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        roundedView.addAnchors(top: nil,
                                       leading: self.leadingAnchor,
                                       bottom: self.bottomAnchor,
                                       trailing: self.trailingAnchor,
                                       size: .init(width: 0, height: (self.frame.height * 0.5)))
        let frontImageHeight: CGFloat = self.frame.height / 3
        frontImageView.addAnchors(top: nil,
                                  leading: self.leadingAnchor,
                                  bottom: nil,
                                  trailing: nil,
                                  padding: .init(top: 0, left: 15, bottom: 0, right: 0),
                                  size: .init(width: frontImageHeight, height: frontImageHeight))
        frontImageView.centerYAnchor.constraint(equalTo: roundedView.topAnchor, constant: 15).isActive = true
        frontImageView.layer.cornerRadius = frontImageHeight/2
        
        stationNameLabel.addAnchors(top: nil,
                                    leading: frontImageView.trailingAnchor,
                                    bottom: backgroundImageView.bottomAnchor,
                                    trailing: nil,
                                    padding: .init(top: 0, left: 0, bottom: 10, right: 0))
        followersLabel.addAnchors(top: backgroundImageView.bottomAnchor,
                                  leading: stationNameLabel.leadingAnchor,
                                  bottom: nil,
                                  trailing: nil,
                                  padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        stationInfoLabel.addAnchors(top: frontImageView.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: self.bottomAnchor,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 10, left: 25, bottom: 0, right: 25))
        followButton.addAnchors(top: nil,
                                leading: nil,
                                bottom: nil,
                                trailing: self.trailingAnchor,
                                padding: .init(top: 0, left: 0, bottom: 0, right: 15))
        followButton.centerYAnchor.constraint(equalTo: followersLabel.centerYAnchor).isActive = true
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
        followButton.setTitle("Follow", for: .normal)
        //followButton.backgroundColor = .blue
    }
    func followedButton(){
        followButton.setTitle("Followed", for: .normal)
        //followButton.backgroundColor = .yellow
    }
    func changeFollowerCount(by number: Int){
        if number >= 1000{
            followersLabel.text = "\(number/1000)k Followers"
        }else{
            followersLabel.text = "\(number) Followers"
        }

    }
}
