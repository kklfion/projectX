//
//  ProfileView.swift
//  projectX
//
//  Created by Radomyr Bezghin on 9/23/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    let headerGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [Constants.Colors.profileBlue.cgColor, Constants.Colors.profileYellow.cgColor]
        gradient.locations = [0,0.8]
        gradient.shouldRasterize = true
        return gradient
    }()
    let viewBackground: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.mainBackground
        view.layer.cornerRadius = 25
        return view
    }()
    let profileImageViewContainer: UIView = {
        let container = UIView()
        container.clipsToBounds = false
        container.layer.shadowColor = Constants.Colors.shadow.cgColor
        container.layer.shadowOpacity = 1
        container.layer.shadowOffset = CGSize.zero
        container.layer.shadowRadius = 8
        container.layer.shadowPath = UIBezierPath(roundedRect: container.bounds, cornerRadius: 10).cgPath
        return container
    }()
    let profileImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.backgroundColor = Constants.Colors.secondaryBackground
        imageview.clipsToBounds = true
        
        return imageview
    }()
    let followButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(rgb: 0xf6e58f)
        button.layer.cornerRadius = 30; // this value vary as per your desire
        button.clipsToBounds = true;
        return button
    }()
    let bioStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillProportionally
        stack.alignment = .center
        stack.spacing = 5
        stack.axis = .vertical
        return stack
    }()
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = Constants.Colors.mainText
        return label
    }()
    let useridLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = Constants.Colors.subText
        return label
    }()
    let schoolLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = Constants.Colors.mainText
        return label
    }()
    let spacingView: UIView  = {
        let view = UIView()
        //view.backgroundColor = .lightGray
        view.alpha = 0.1
        view.layer.cornerRadius = 1
        return view
    }()
    private func setupViews() {
        //self.backgroundColor = .blue
        headerGradient.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: (self.frame.width*0.5) + 25)
        self.layer.addSublayer(headerGradient)

        viewBackground.frame = CGRect(x: 0, y: (self.frame.width*0.4), width: self.frame.width, height: 100)
        self.addSubview(viewBackground)

        profileImageViewContainer.addSubview(profileImageView)
        profileImageView.addAnchors(top: profileImageViewContainer.topAnchor, leading: profileImageViewContainer.leadingAnchor, bottom: profileImageViewContainer.bottomAnchor, trailing: profileImageViewContainer.trailingAnchor)

        profileImageViewContainer.addSubview(followButton)
        followButton.centerXAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: -30).isActive = true
        followButton.centerYAnchor.constraint(equalTo: profileImageView.bottomAnchor,constant: -30).isActive = true

        followButton.addAnchors(top: nil,leading: nil,bottom: nil,trailing: nil,size: .init(width: 60, height: 60))

        self.addSubview(profileImageViewContainer)
        //self.addSubview(followButton)
        self.addSubview(bioStackView)
        self.addSubview(spacingView)

        bioStackView.addArrangedSubview(usernameLabel)
        bioStackView.addArrangedSubview(useridLabel)
        bioStackView.addArrangedSubview(schoolLabel)

        profileImageViewContainer.addAnchors(top: nil,
                                     leading: nil,
                                     bottom: nil,
                                     trailing: nil,
                                     padding: .init(top: 0 , left: 0, bottom: 0, right: 0),
                                     size: .init(width: self.frame.width*0.5, height: self.frame.width*0.5))
        profileImageViewContainer.centerYAnchor.constraint(equalTo: viewBackground.topAnchor).isActive = true
        profileImageViewContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        profileImageView.layer.cornerRadius = (self.frame.width*0.5 / 2)
        profileImageViewContainer.layer.cornerRadius = (self.frame.width*0.5 / 2)

        bioStackView.addAnchors(top: profileImageViewContainer.bottomAnchor,
                                            leading: self.leadingAnchor,
                                            bottom: nil,
                                            trailing: self.trailingAnchor,
                                            padding: .init(top: 10, left: 0, bottom: 0, right: 0))

        spacingView.addAnchors(top: bioStackView.bottomAnchor,
                                leading: self.leadingAnchor,
                                bottom: nil,
                                trailing: self.trailingAnchor,
                                padding: .init(top: 10, left: 10, bottom: 0, right: 10),
                                size: .init(width: 0, height: 2))
    }
    func setFollowButtonToFollowed(){
        followButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
    }
    func setFollowButtonToNotFollowed(){
        followButton.setImage(UIImage(systemName: "plus"), for: .normal)
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            self.headerGradient.colors = [Constants.Colors.profileBlue.cgColor, Constants.Colors.profileYellow.cgColor]
        }
    }
}
