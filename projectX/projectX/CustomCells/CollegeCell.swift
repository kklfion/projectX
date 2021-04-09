//
//  CollegeCell.swift
//  projectX
//
//  Created by Radomyr Bezghin on 2/10/21.
//  Copyright © 2021 Radomyr Bezghin. All rights reserved.
//

import UIKit

class CollegeCell: ShadowUICollectionViewCell {
    
    //let cornerRadius: CGFloat = 10
    
    let schoolImageView: UIImageView = {
        let view = UIImageView()
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
    let followButton: ShadowRoundUIButton = {
        let button = ShadowRoundUIButton()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContentView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        // school image
        let imageHeight = self.frame.height * 0.6
        schoolImageView.translatesAutoresizingMaskIntoConstraints = false
        schoolImageView.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        schoolImageView.widthAnchor.constraint(equalToConstant: imageHeight).isActive = true
        schoolImageView.layer.cornerRadius = imageHeight/2
        schoolImageView.clipsToBounds = true
    }
    
    func setCollegeBackgroundColor(colorHex: String){
        schoolImageView.backgroundColor = UIColor.blue
    }
    
    private func setupContentView(){
        contentView.backgroundColor = .white
        
        let infoStack = UIStackView(arrangedSubviews: [schoolNameLabel, schoolFollowersLabel])
        infoStack.axis = .vertical
        infoStack.alignment = .leading
        
        let stack = UIStackView(arrangedSubviews: [schoolImageView, infoStack])
        stack.axis = .horizontal
        stack.spacing = 30
        stack.alignment = .center
        
//        contentView.addSubview(followButton)
//        followButton.addAnchors(top: contentView.topAnchor,
//                                leading: nil,
//                                bottom: nil,
//                                trailing: contentView.trailingAnchor,
//                                padding: .init(top: 10, left: 0, bottom: 0, right: 10),
//                                size: .init(width: 40, height: 40))

        contentView.addSubview(stack)
        stack.addAnchors(top: contentView.topAnchor,
                             leading: contentView.leadingAnchor,
                             bottom: contentView.bottomAnchor,
                             trailing: contentView.trailingAnchor,
                             padding: .init(top: 10, left: 10, bottom: 10, right: 10))
    }
//    func setFollowButtonToFollowed(){
//        followButton.setImage(followButton.followedImage, for: .normal)
//    }
//    func setFollowButtonToNotFollowed(){
//        followButton.setImage(followButton.notFollowedImage, for: .normal)
//    }
}
