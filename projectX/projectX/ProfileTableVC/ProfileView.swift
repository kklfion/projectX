//
//  ProfileView.swift
//  projectX
//
//  Created by Radomyr Bezghin on 9/23/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    private var toggle: Bool = true

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    let profileImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.layer.borderWidth = 0.5
        imageview.layer.borderColor = UIColor.black.cgColor
        imageview.clipsToBounds = true
        return imageview
    }()
    let bioStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillProportionally
        stack.alignment = .center
        stack.spacing = 10
        stack.axis = .vertical
        return stack
    }()
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .black
        return label
    }()
    let useridLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .lightGray
        return label
    }()
    let schoolLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .black
        return label
    }()
    let spacingView: UIView  = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.alpha = 0.5
        return view
    }()

    var tableViewAndCollectionView: SegmentedControlWithTableViewAndCollectionView?
    
    private func setupViews(frame: CGRect) {
        
        self.addSubview(profileImageView)
        self.addSubview(bioStackView)
        self.addSubview(spacingView)
        
        bioStackView.addArrangedSubview(usernameLabel)
        bioStackView.addArrangedSubview(useridLabel)
        bioStackView.addArrangedSubview(schoolLabel)
        
        profileImageView.addAnchors(top: self.safeAreaLayoutGuide.topAnchor,
                                     leading: nil,
                                     bottom: nil,
                                     trailing: nil,
                                     padding: .init(top: 0, left: 0, bottom: 0, right: 0),
                                     size: .init(width: self.frame.width*0.5, height: self.frame.width*0.5))
        profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        profileImageView.layer.cornerRadius = (self.frame.width*0.5 / 2)
        
        bioStackView.addAnchors(top: profileImageView.bottomAnchor,
                                            leading: self.leadingAnchor,
                                            bottom: nil,
                                            trailing: self.trailingAnchor,
                                            padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
        spacingView.addAnchors(top: bioStackView.bottomAnchor,
                                leading: self.leadingAnchor,
                                bottom: nil,
                                trailing: self.trailingAnchor,
                                padding: .init(top: 10, left: 10, bottom: 0, right: 10),
                                size: .init(width: 0, height: 1))
        
        tableViewAndCollectionView = SegmentedControlWithTableViewAndCollectionView(frame: frame)
        self.addSubview(tableViewAndCollectionView!)
        tableViewAndCollectionView?.addAnchors(top: spacingView.bottomAnchor,
                                     leading: self.leadingAnchor,
                                     bottom: self.bottomAnchor,
                                     trailing: self.trailingAnchor,
                                     padding: .init(top: 0, left: 0, bottom: 0, right: 0),
                                     size: .init(width: 0, height: 0))
        
    }
}
