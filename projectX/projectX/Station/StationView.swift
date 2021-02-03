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
    
    let topViewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    let frontImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    let stationNameLabel: UILabel = {
        let label = UILabel()
        //label.text = "University"
        label.font = Constants.headlineTextFont
        label.numberOfLines = 1
        return label
    }()
    let followersLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Constants.bodyTextFont
        //label.text = v
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
        self.backgroundColor = .white
        [topViewContainer].forEach {self.addSubview($0)}
        topViewContainer.addAnchors(top: self.topAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    size: .init(width: self.frame.width, height: self.frame.height*0.3))
        
        topViewContainer.layoutIfNeeded()//foces to setup proper frame?!?!??!  super important ahahah
        
        [backgroundImageView, frontImageView, followersLabel,stationInfoLabel,stationNameLabel,followButton].forEach({topViewContainer.addSubview($0)})
        
        backgroundImageView.addAnchors(top: topViewContainer.topAnchor,
                                       leading: topViewContainer.leadingAnchor,
                                       bottom: nil,
                                       trailing: topViewContainer.trailingAnchor,
                                       size: .init(width: topViewContainer.frame.width, height: topViewContainer.frame.height / 2))
        frontImageView.addAnchors(top: nil,
                                  leading: topViewContainer.leadingAnchor,
                                  bottom: nil,
                                  trailing: nil,
                                  padding: .init(top: 0, left: 15, bottom: 0, right: 0),
                                  size: .init(width: topViewContainer.frame.height/3, height: topViewContainer.frame.height/3))
        frontImageView.centerYAnchor.constraint(equalTo: backgroundImageView.bottomAnchor).isActive = true
        frontImageView.layer.cornerRadius = ((topViewContainer.frame.height/3) / 2)
        
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
                                    leading: topViewContainer.leadingAnchor,
                                    bottom: topViewContainer.bottomAnchor,
                                    trailing: topViewContainer.trailingAnchor,
                                    padding: .init(top: 10, left: 25, bottom: 0, right: 25))
        followButton.addAnchors(top: nil,
                                leading: nil,
                                bottom: nil,
                                trailing: topViewContainer.trailingAnchor,
                                padding: .init(top: 0, left: 0, bottom: 0, right: 15))
        followButton.centerYAnchor.constraint(equalTo: followersLabel.centerYAnchor).isActive = true
    }
}
//MARK: helper functions
extension StationView {
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
