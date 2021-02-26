//
//  CollegeCell.swift
//  projectX
//
//  Created by Radomyr Bezghin on 2/10/21.
//  Copyright © 2021 Radomyr Bezghin. All rights reserved.
//

import UIKit
class CollegeCell: UICollectionViewCell {
    
    let cornerRadius: CGFloat = 10
    
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
    override func layoutSubviews() {
        super.layoutSubviews()
        // Improve scrolling performance with an explicit shadowPath
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: cornerRadius
        ).cgPath
        // school image
        let imageHeight = self.frame.height * 0.6
        schoolImageView.translatesAutoresizingMaskIntoConstraints = false
        schoolImageView.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        schoolImageView.widthAnchor.constraint(equalToConstant: imageHeight).isActive = true
        schoolImageView.layer.cornerRadius = imageHeight/2
        schoolImageView.clipsToBounds = true
    }
    
    private func setupContentView(){
        
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
        
        
        
        contentView.backgroundColor = .white
        
        let infoStack = UIStackView(arrangedSubviews: [schoolNameLabel, schoolFollowersLabel])
        infoStack.axis = .vertical
        
        let stack = UIStackView(arrangedSubviews: [schoolImageView, infoStack])
        stack.axis = .horizontal

        contentView.addSubview(stack)
        stack.addAnchors(top: contentView.topAnchor,
                             leading: contentView.leadingAnchor,
                             bottom: contentView.bottomAnchor,
                             trailing: contentView.trailingAnchor,
                             padding: .init(top: 10, left: 10, bottom: 10, right: 10))
    }
}
