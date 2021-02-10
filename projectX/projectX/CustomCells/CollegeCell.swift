//
//  CollegeCell.swift
//  projectX
//
//  Created by Radomyr Bezghin on 2/10/21.
//  Copyright © 2021 Radomyr Bezghin. All rights reserved.
//

import UIKit
class CollegeCell: UICollectionViewCell {
    let schoolImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "sslug")
        view.contentMode = .scaleAspectFit
        return view
    }()
    let schoolNameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.headlineTextFont
        return label
    }()
    let schoolFollowersLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.bodyTextFont
        return label
    }()
    let followButton: UIButton = {
        let button = UIButton()
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContentView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupContentView(){
        
        contentView.backgroundColor = .white
        
        let infoStack = UIStackView(arrangedSubviews: [schoolNameLabel, schoolFollowersLabel])
        infoStack.axis = .vertical
        
        let imageSize: CGFloat = 60
        schoolImageView.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        schoolImageView.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        schoolImageView.layer.cornerRadius = imageSize/2
        schoolImageView.clipsToBounds = true
        
        contentView.addSubview(schoolImageView)
        schoolImageView.addAnchors(top: nil,
                                   leading: contentView.leadingAnchor,
                                   bottom: nil,
                                   trailing: nil,
                                   padding: .init(top: 0, left: 20, bottom: 0, right: 0))
        schoolImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -20).isActive = true
        contentView.addSubview(infoStack)
        infoStack.addAnchors(top: contentView.topAnchor,
                             leading: schoolImageView.trailingAnchor,
                             bottom: contentView.bottomAnchor,
                             trailing: contentView.trailingAnchor,
                             padding: .init(top: 10, left: 10, bottom: 10, right: 10))
    }
}
