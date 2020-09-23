//
//  CommentTableViewCell.swift
//  testing
//
//  Created by Radomyr Bezghin on 9/9/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    static let cellID = "CommentTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        backgroundColor = .clear
        setupContentView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupContentView()
    }
    ///top stack
    let extraTitleStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
     let optionalAuthorExtraTitle: UILabel = {
        let label = UILabel()
        label.text = "Deans Honor"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .left
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
     lazy var extraTitleImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = (UIImage(systemName: "star")?.withTintColor(.yellow, renderingMode: .alwaysOriginal))
        return iv
    }()
    ///2nd stack
    private let authorStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private lazy var circleBadgeView: UIImageView = {
        let iv = UIImageView()
        iv.image = (UIImage(systemName: "circle")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal))
        return iv
    }()
    let authorTitleLable: UILabel = {
        let label = UILabel()
        label.text = "u/Sammy"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .lightGray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let dateTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "1h"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .right
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    /// main comment area stack
    private let commentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let commentLabel: UILabel = {
        let text = UILabel()
        text.font = UIFont.preferredFont(forTextStyle: .callout)
        text.numberOfLines = 0
        text.adjustsFontSizeToFitWidth = false
        text.lineBreakMode = .byTruncatingTail
        text.text = "i am autoresizing text cell i am autoresizing text cell i am autoresizing text cell i am autoresizing text cell i am autoresizing text cell i am autoresizing text cell  "
        text.textColor = .black
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    ///bottom stack
    private let likesStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.backgroundColor = .black
        stack.alpha = 0.5
        stack.spacing = 10
        stack.layer.borderWidth = 0.5
        stack.layer.borderColor = UIColor.black.cgColor
        stack.layer.cornerRadius = 10
        stack.layoutMargins = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private let likeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.addTarget(self, action: #selector(likeButtonTouched), for: .touchUpInside)
        return button
    }()
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let dislikeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.addTarget(self, action: #selector(dislikeButtonTouched), for: .touchUpInside)
        return button
    }()
    
    private func  setupContentView(){
        [optionalAuthorExtraTitle, extraTitleImageView].forEach({extraTitleStackView.addArrangedSubview($0)})
        [authorTitleLable, dateTimeLabel].forEach { authorStackView.addArrangedSubview($0)}
        [commentLabel].forEach { commentStackView.addArrangedSubview($0)}
        [likeButton,likesLabel,dislikeButton].forEach { likesStackView.addArrangedSubview($0)}
        [extraTitleStackView,authorStackView,commentStackView,likesStackView].forEach({self.contentView.addSubview($0)})
        
        extraTitleStackView.addAnchors(top: contentView.topAnchor,
                                    leading: contentView.leadingAnchor,
                                    bottom: nil,
                                    trailing: nil,
                                    padding: .init(top: Constants.standardPadding, left: Constants.standardPadding, bottom: 0, right: 0))
        authorStackView.addAnchors(top: extraTitleStackView.bottomAnchor,
                                    leading: contentView.leadingAnchor,
                                    bottom: nil,
                                    trailing: nil,
                                    padding: .init(top: 0, left: Constants.standardPadding, bottom: 0, right: 0))
        commentStackView.addAnchors(top: authorStackView.bottomAnchor,
                                    leading: contentView.leadingAnchor,
                                    bottom: nil,
                                    trailing: contentView.trailingAnchor,
                                    padding: .init(top: Constants.standardPadding, left: Constants.standardPadding, bottom: 0, right: Constants.standardPadding))
        likesStackView.addAnchors(top: commentStackView.bottomAnchor,
                                    leading: commentStackView.leadingAnchor,
                                    bottom: contentView.bottomAnchor,
                                    trailing: nil,
                                    padding: .init(top: Constants.standardPadding, left: 0, bottom: Constants.standardPadding, right: 0))
   
    }

}
