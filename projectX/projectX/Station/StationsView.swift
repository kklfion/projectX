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
    let topViewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
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
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.black.cgColor
        return iv
    }()
    let stationNameLabel: UILabel = {
        let label = UILabel()
        label.text = "University"
        label.font = Constants.headlineTextFont
        label.numberOfLines = 1
        return label
    }()
    let followersLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Constants.bodyTextFont
        label.text = "666k Followers"
        return label
    }()
    let followButton: UIButton = {
        let button = UIButton()
        button.setTitle("Followed!", for: .normal)
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
        label.numberOfLines = 0
        label.font = Constants.bodyTextFont
        label.text = "Yeeet. Blah blah. Can I graduate on time. I want to drink. Maybe a boba too!"
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
    let stationsTableView: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = UIColor.init(red: 223/255.0, green: 230/255.0, blue: 233/255.0, alpha: 1.0)
        tableview.separatorStyle = .none
        return tableview
    }()
    
    var topViewContainerTopConstraint: NSLayoutConstraint?
    
    func setupViews(){
        self.backgroundColor = .white 
        [topViewContainer, stationsTableView].forEach {self.addSubview($0)}
        topViewContainer.addAnchors(top: nil,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    size: .init(width: self.frame.width, height: self.frame.height*0.3))
        topViewContainerTopConstraint = topViewContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 0)
        topViewContainerTopConstraint?.isActive = true
        layoutIfNeeded()//foces to setup proper frame?!?!??!  super important ahahah
        stationsTableView.addAnchors(top: topViewContainer.bottomAnchor,
                                     leading: self.leadingAnchor,
                                     bottom: self.bottomAnchor,
                                     trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
         
        [backgroundImageView, frontImageView, followersLabel,stationInfoLabel,stationNameLabel,followButton,segmentedControl].forEach({topViewContainer.addSubview($0)})
        
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
                                    bottom: segmentedControl.topAnchor,
                                    trailing: topViewContainer.trailingAnchor,
                                    padding: .init(top: 10, left: 25, bottom: 0, right: 25))
        segmentedControl.addAnchors(top: nil, leading: topViewContainer.layoutMarginsGuide.leadingAnchor,
                                    bottom: topViewContainer.bottomAnchor,
                                    trailing: topViewContainer.layoutMarginsGuide.trailingAnchor,
                                    padding: .init(top: 0, left: 10, bottom: 10, right: 10))
        followButton.addAnchors(top: nil,
                                leading: nil,
                                bottom: nil,
                                trailing: topViewContainer.trailingAnchor,
                                padding: .init(top: 0, left: 0, bottom: 0, right: 15))
        followButton.centerYAnchor.constraint(equalTo: followersLabel.centerYAnchor).isActive = true
        //followButton.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        
    }


}
