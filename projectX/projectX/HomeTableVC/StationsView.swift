//
//  StationsView.swift
//  projectX
//
//  Created by Radomyr Bezghin on 8/2/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

class StationsView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        iv.clipsToBounds = true
        iv.image = UIImage(named: "ucsc1")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    let frontImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .yellow
        iv.clipsToBounds = true
        iv.image = UIImage(named: "sslug")
        //iv.layer.cornerRadius =
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.black.cgColor
        return iv
    }()
    let stationNameLabel: UILabel = {
        let label = UILabel()
        label.text = "University"
        label.font = UIFont.systemFont(ofSize: Constants.mainTextFontSize)
        label.numberOfLines = 1
        return label
    }()
    let followersLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: Constants.mainTextFontSize)
        label.text = "666k Followers"
        
        return label
    }()
    let followButton: UIButton = {
        let button = UIButton()
        button.setTitle(" followed ", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.smallTextFontSize)
        button.layer.borderWidth = Constants.Home.layerBorderWidth
        button.layer.cornerRadius = Constants.Home.cornerRadius
        return button
    }()
    let stationInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: Constants.mainTextFontSize)
        label.text = "Yeeet. Blah blah. Can I graduate on time. I want to drink. Maybe a boba too! - Jordon"
        return label
    }()
    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Lounge", "List"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 0
        sc.selectedSegmentTintColor = .white
        sc.layer.backgroundColor = UIColor.white.cgColor
        sc.tintColor = .white
        //sc.addTarget(self, action: #selector(performAnimation), for: .valueChanged)
        return sc
    }()
    
    
    func setupViews(){
        [backgroundImageView, frontImageView, followersLabel,stationInfoLabel,stationNameLabel,followButton,segmentedControl].forEach({self.addSubview($0)})
        
        backgroundImageView.addAnchors(top: self.topAnchor,
                                       leading: self.leadingAnchor,
                                       bottom: nil,
                                       trailing: self.trailingAnchor,
                                       size: .init(width: self.frame.width, height: self.frame.height / 2))
        frontImageView.addAnchors(top: nil,
                                  leading: self.leadingAnchor,
                                  bottom: nil,
                                  trailing: nil,
                                  padding: .init(top: 0, left: 15, bottom: 0, right: 0),
                                  size: .init(width: self.frame.height/3, height: self.frame.height/3))
        frontImageView.centerYAnchor.constraint(equalTo: backgroundImageView.bottomAnchor).isActive = true
        frontImageView.layer.cornerRadius = ((self.frame.height/3) / 2)
        
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
                                    bottom: nil, trailing: nil,
                                    padding: .init(top: 10, left: 25, bottom: 0, right: 0), size: .init(width: self.frame.width - 50, height: 0))
        segmentedControl.addAnchors(top: nil, leading: self.leadingAnchor,
                                    bottom: self.bottomAnchor,
                                    trailing: self.trailingAnchor)
        followButton.addAnchors(top: backgroundImageView.bottomAnchor,
                                leading: nil,
                                bottom: nil,
                                trailing: self.trailingAnchor,
                                padding: .init(top: 10, left: 0, bottom: 0, right: 15))
    }


}
