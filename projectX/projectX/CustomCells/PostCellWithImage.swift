//
//  PostCell.swift
//  projectX
//
//  Created by Radomyr Bezghin on 6/29/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//
/*

 TODO:
 1. Create the view
 2. change constraints from nubmers to variables or ratios
 3. populate with some data
 
 
*/
import UIKit

class PostCellWithImage: UITableViewCell {
    static let cellID = "PostCellWithImage"

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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let dateUILabel: UILabel = {
        let label = UILabel()
        label.text = "1h"
        label.font = Constants.smallerTextFont
        label.textAlignment = .right
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let channelUIButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Food", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = Constants.smallerTextFont
        button.contentEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    let titleUILabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = Constants.headlineTextFont
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let previewUILabel: UILabel = {
        let text = UILabel()
        text.font = Constants.bodyTextFont
        text.numberOfLines = 0
        text.adjustsFontSizeToFitWidth = false
        text.lineBreakMode = .byTruncatingTail
        text.text = "Preview"
        text.textColor = .black
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()

    let authorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "sslug")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let authorUILabel: UILabel = {
        let label = UILabel()
        label.text = "u/Sammy"
        label.font = Constants.smallerTextFont
        label.textColor = .lightGray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    ///bottom stack
    let bottomStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    private let likesStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    private let likeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "chevron.up")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal), for: .normal)
        //button.addTarget(self, action: #selector(likeButtonTouched), for: .touchUpInside)
        return button
    }()
    let likesLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .black
        label.textAlignment = .center
        label.font = Constants.smallerTextFont
        label.numberOfLines = 1
        return label
    }()
    private let dislikeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "arrowtriangle.down.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal), for: .normal)
        //button.addTarget(self, action: #selector(dislikeButtonTouched), for: .touchUpInside)
        return button
    }()
    let commentsUIButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "bubble.right.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    let commentsUILabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Constants.smallerTextFont
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    let postUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        setupContentView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupContentView()
    }
    func setupContentView(){
        
        contentView.backgroundColor = .white
        
        [dateUILabel,channelUIButton, titleUILabel, previewUILabel, bottomStackView, postUIImageView, authorImageView, authorUILabel]
            .forEach {containerView.addSubview($0)}
        [likeButton,likesLabel,dislikeButton].forEach { likesStackView.addArrangedSubview($0)}
        [likesStackView, commentsUIButton, commentsUILabel].forEach ({bottomStackView.addArrangedSubview($0)})
        dateUILabel.addAnchors(top: containerView.topAnchor,
                           leading: nil,
                           bottom: nil,
                           trailing: channelUIButton.leadingAnchor,
                           padding: .init(top: 10, left: 0, bottom: 0, right: 10),
                           size: .init(width: 0, height: 0))
        channelUIButton.addAnchors(top: nil,
                               leading: nil,
                               bottom: nil,
                               trailing: bottomStackView.trailingAnchor,
                               padding: .init(top: 10, left: 0, bottom: 0, right: 0),
                               size: .init(width: 0, height: 0))
        channelUIButton.centerYAnchor.constraint(equalTo: dateUILabel.centerYAnchor).isActive = true
        postUIImageView.addAnchors(top: nil,
                               leading: nil,
                               bottom: nil,
                               trailing: containerView.trailingAnchor,
                               padding: .init(top: 0, left: 0, bottom: 0, right: 0),
                               size: .init(width: contentView.frame.height * 2.5 , height: contentView.frame.height * 2.5))
        postUIImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        titleUILabel.addAnchors(top: dateUILabel.bottomAnchor,
                            leading: containerView.leadingAnchor,
                            bottom: previewUILabel.topAnchor,
                            trailing: previewUILabel.trailingAnchor,
                            padding: .init(top: 10, left: 10, bottom: 0, right: 0))
        previewUILabel.addAnchors(top: titleUILabel.bottomAnchor,
                              leading: containerView.leadingAnchor,
                              bottom: authorImageView.topAnchor,
                              trailing: postUIImageView.leadingAnchor,
                              padding: .init(top: 0, left: 10, bottom: 10, right: 0))
        
        authorImageView.addAnchors(top: nil,
                             leading: containerView.leadingAnchor,
                             bottom: containerView.bottomAnchor,
                             trailing: nil,
                             padding: .init(top: 0, left: 10, bottom: 10, right: 0),
                             size: .init(width: contentView.frame.width*0.1, height: contentView.frame.width*0.1))
        authorUILabel.addAnchors(top: nil,
                             leading: authorImageView.trailingAnchor,
                             bottom: nil,
                             trailing: nil,
                             padding: .init(top: 0, left: 10, bottom: 0, right: 0))
        authorUILabel.centerYAnchor.constraint(equalTo: authorImageView.centerYAnchor).isActive = true
        bottomStackView.addAnchors(top: nil,
                            leading: nil,
                            bottom: nil,
                            trailing: nil,
                            padding: .init(top: 0, left: 0, bottom: 0, right: 0),
                            size: .init(width: 0 , height: 0))
        bottomStackView.centerYAnchor.constraint(equalTo: authorImageView.centerYAnchor).isActive = true
        bottomStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        ///finish up by adding views to the content view
        [shadowLayerView,containerView].forEach({contentView.addSubview($0)})
        containerView.addAnchors(top: contentView.safeAreaLayoutGuide.topAnchor,
                          leading: contentView.safeAreaLayoutGuide.leadingAnchor,
                          bottom: contentView.safeAreaLayoutGuide.bottomAnchor,
                          trailing: contentView.safeAreaLayoutGuide.trailingAnchor,
                          padding: .init(top: 10, left: 10, bottom: 10, right: 10),
                          size: .init(width: 0, height: 0))
        shadowLayerView.addAnchors(top: contentView.safeAreaLayoutGuide.topAnchor,
                          leading: contentView.safeAreaLayoutGuide.leadingAnchor,
                          bottom: contentView.safeAreaLayoutGuide.bottomAnchor,
                          trailing: contentView.safeAreaLayoutGuide.trailingAnchor,
                          padding: .init(top: 10, left: 10, bottom: 10, right: 10),
                          size: .init(width: 0, height: 0))

    
    }
}

