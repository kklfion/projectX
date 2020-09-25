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

class PostCell: UITableViewCell {
    
    let padding:CGFloat = 5
    let rowHeight:CGFloat = 18
    let titleFontSize = 18
    
    var UID: String?// ????
    /// is set to rightUIViewLeading anchor if there is an image otherwise it is set to the end of the screen
    var previewTrailingAnchor: NSLayoutConstraint!
    var withImageAnchor: NSLayoutConstraint!
    var rightViewWidthAnchor: NSLayoutConstraint!
    let imageIconName = "image_icon"
    /// Creates a view left side of the post
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let dateUILabel: UILabel = {
        let label = UILabel()
        label.text = "1h"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .right
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let channelUIButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Food", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.contentEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    let titleUILabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.boldSystemFont(ofSize: 16 )
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let previewUILabel: UILabel = {
        let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 14 )
        text.numberOfLines = 5
        text.adjustsFontSizeToFitWidth = false
        text.lineBreakMode = .byTruncatingTail
        text.text = "Preview"
        text.textColor = .black
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    let bottomStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let authorUILabel: UILabel = {
        let label = UILabel()
        label.text = "u/Sammy"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let heartUIButton: UIButton = {
        let button = UIButton(type: .custom)
        //button.backgroundColor = .red
        button.setImage(UIImage(named: "post_heart_icon"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let likesUILabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .orange
        label.text = "13"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let commentsUIButton: UIButton = {
        let button = UIButton(type: .custom)
        //button.backgroundColor = .blue
        button.setImage(UIImage(named: "post_comment_icon"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let commentsUILabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .yellow
        label.text = "3"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    /// views for the right side
    let rightUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let postUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        //imageView.image = UIImage(named: "post_image_icon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let separatorLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .none
        return view
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
        [dateUILabel,channelUIButton, titleUILabel, previewUILabel, bottomStackView, postUIImageView, authorUILabel].forEach {containerView.addSubview($0)}
        [heartUIButton, likesUILabel, commentsUIButton, commentsUILabel].forEach ({bottomStackView.addArrangedSubview($0)})
        dateUILabel.addAnchors(top: containerView.topAnchor,
                           leading: nil,
                           bottom: nil,
                           trailing: channelUIButton.leadingAnchor,
                           padding: .init(top: padding, left: 0, bottom: 0, right: padding),
                           size: .init(width: 0, height: 0))
        channelUIButton.addAnchors(top: nil,
                               leading: nil,
                               bottom: nil,
                               trailing: bottomStackView.trailingAnchor,
                               padding: .init(top: padding, left: 0, bottom: 0, right: 0),
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
                            padding: .init(top: padding, left: padding, bottom: 0, right: 0))
        previewUILabel.addAnchors(top: titleUILabel.bottomAnchor,
                              leading: containerView.leadingAnchor,
                              bottom: bottomStackView.topAnchor,
                              trailing: nil,
                              padding: .init(top: 0, left: padding, bottom: padding, right: 0))
        previewTrailingAnchor = previewUILabel.trailingAnchor.constraint(equalTo: postUIImageView.leadingAnchor)
        previewTrailingAnchor.isActive = true
        
        authorUILabel.addAnchors(top: nil,
                             leading: containerView.leadingAnchor,
                             bottom: containerView.bottomAnchor,
                             trailing: nil,
                             padding: .init(top: 0, left: padding, bottom: padding, right: 0),
                             size: .init(width: 0, height: 0))
        bottomStackView.addAnchors(top: nil,
                            leading: nil,
                            bottom: containerView.bottomAnchor,
                            trailing: nil,
                            padding: .init(top: 0, left: 0, bottom: padding, right: 0),
                            size: .init(width: contentView.frame.width / 2 , height: rowHeight))
        bottomStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        ///finish up by adding views to the content view
        [containerView,separatorLine].forEach({contentView.addSubview($0)})
        containerView.addAnchors(top: contentView.safeAreaLayoutGuide.topAnchor,
                          leading: contentView.safeAreaLayoutGuide.leadingAnchor,
                          bottom: separatorLine.topAnchor,
                          trailing: contentView.safeAreaLayoutGuide.trailingAnchor,
                          padding: .init(top: 0, left: 0, bottom: 0, right: 0),
                          size: .init(width: 0, height: 0))
        separatorLine.addAnchors(top: nil,
                          leading: contentView.safeAreaLayoutGuide.leadingAnchor,
                          bottom: contentView.safeAreaLayoutGuide.bottomAnchor,
                          trailing: contentView.safeAreaLayoutGuide.trailingAnchor,
                          padding: .init(top: 0, left: 0, bottom: 0, right: 0),
                          size: .init(width: 0, height: 1))
    
    }
    /// changes constraints so that main view takes extra space
    func noImageViewConstraints(){
        previewTrailingAnchor.isActive = false
        previewTrailingAnchor = previewUILabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        previewTrailingAnchor.isActive = true
        postUIImageView.isHidden = true

    }
    /// changes constraints so that there is room for the image
    func withImageViewConstraints(){
        previewTrailingAnchor.isActive = false
        previewTrailingAnchor = previewUILabel.trailingAnchor.constraint(equalTo: postUIImageView.leadingAnchor)
        previewTrailingAnchor.isActive = true
        postUIImageView.isHidden = false
    }
}

