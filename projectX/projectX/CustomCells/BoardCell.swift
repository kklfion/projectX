//
//  BoardCell.swift
//  projectX
//
//  Created by Radomyr Bezghin on 10/17/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

class BoardCell: UICollectionViewCell {
    static let cellID = "BoardCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        setupContentView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupContentView()
    }
    let shadowLayerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.4
        return view
    }()
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    let boardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sslug")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let descriptionLabel: UILabel = {
        let text = UILabel()
        text.font = Constants.bodyTextFont
        text.numberOfLines = 2
        text.text = "Fix my laptop, bro. PLLEEEEAASE"
        text.adjustsFontSizeToFitWidth = false
        text.lineBreakMode = .byTruncatingTail
        text.textColor = .black
        return text
    }()
    let locationStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = 0
        return stack
    }()
    let locationButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "location")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    let locationLabel: UILabel = {
        let text = UILabel()
        text.font = Constants.bodyTextFont
        text.numberOfLines = 1
        text.text = "Santa Cruz, CA"
        text.adjustsFontSizeToFitWidth = false
        text.lineBreakMode = .byTruncatingTail
        text.textColor = .black
        return text
    }()
    func setupContentView(){
        contentView.backgroundColor = .white
        [shadowLayerView,containerView].forEach({contentView.addSubview($0)})
        containerView.addAnchors(top: contentView.safeAreaLayoutGuide.topAnchor,
                          leading: contentView.safeAreaLayoutGuide.leadingAnchor,
                          bottom: contentView.safeAreaLayoutGuide.bottomAnchor,
                          trailing: contentView.safeAreaLayoutGuide.trailingAnchor,
                          padding: .init(top: 10, left: 10, bottom: 10, right: 10),
                          size: .init(width: 0, height: 0))
        shadowLayerView.addAnchors(top: containerView.topAnchor,
                          leading: containerView.leadingAnchor,
                          bottom: containerView.bottomAnchor,
                          trailing: containerView.trailingAnchor)
        
        [boardImageView,descriptionLabel,locationStackView].forEach({containerView.addSubview($0)})
        boardImageView.addAnchors(top: containerView.topAnchor,
                                  leading: nil,
                                  bottom: nil,
                                  trailing: nil,
                                  size: .init(width: contentView.frame.width*0.7, height: contentView.frame.width*0.7))
        boardImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        descriptionLabel.addAnchors(top: boardImageView.bottomAnchor,
                                    leading: containerView.leadingAnchor,
                                    bottom: nil,
                                    trailing: containerView.trailingAnchor,
                                    padding: .init(top: 10, left: 10, bottom: 0, right: 10))
        locationStackView.addAnchors(top: descriptionLabel.bottomAnchor,
                                    leading: containerView.leadingAnchor,
                                    bottom: containerView.bottomAnchor,
                                    trailing: containerView.trailingAnchor,
                                    padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        [locationButton, locationLabel].forEach({locationStackView.addArrangedSubview($0)})
    }
}
