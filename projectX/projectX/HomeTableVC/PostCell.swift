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
    let leftUIView: UIView = {
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
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(.lightGray, for: .normal)
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let titleUILabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.boldSystemFont(ofSize: 17 )
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let previewUILabel: UILabel = {
        let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 14 )
        text.numberOfLines = 2
        text.adjustsFontSizeToFitWidth = false
        text.lineBreakMode = .byTruncatingTail
        text.text = "Preview"
        text.textColor = .black
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    let bottomUIView: UIStackView = {
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
        [dateUILabel,channelUIButton, titleUILabel, previewUILabel, bottomUIView, postUIImageView, authorUILabel].forEach {leftUIView.addSubview($0)}
        [heartUIButton, likesUILabel, commentsUIButton, commentsUILabel].forEach ({bottomUIView.addArrangedSubview($0)})
        dateUILabel.anchor(top: leftUIView.topAnchor,
                           leading: nil,
                           bottom: nil,
                           trailing: channelUIButton.leadingAnchor,
                           padding: .init(top: padding, left: 0, bottom: 0, right: padding),
                           size: .init(width: 30, height: rowHeight))
        channelUIButton.anchor(top: leftUIView.topAnchor,
                               leading: nil,
                               bottom: nil,
                               trailing: postUIImageView.leadingAnchor,
                               padding: .init(top: padding, left: 0, bottom: 0, right: 0),
                               size: .init(width: 60, height: rowHeight))
        postUIImageView.anchor(top: nil,
                               leading: nil,
                               bottom: nil,
                               trailing: leftUIView.trailingAnchor,
                               padding: .init(top: 0, left: 0, bottom: 0, right: 0),
                               size: .init(width: contentView.frame.height * 2.5 , height: contentView.frame.height * 2.5))
        postUIImageView.centerYAnchor.constraint(equalTo: leftUIView.centerYAnchor).isActive = true
        titleUILabel.anchor(top: dateUILabel.bottomAnchor,
                            leading: leftUIView.leadingAnchor,
                            bottom: nil,
                            trailing: postUIImageView.leadingAnchor,
                            padding: .init(top: padding, left: padding, bottom: 0, right: 0),
                            size: .init(width: 0, height: rowHeight))
        previewTrailingAnchor = previewUILabel.trailingAnchor.constraint(equalTo: postUIImageView.leadingAnchor)
        previewUILabel.anchor(top: titleUILabel.bottomAnchor,
                              leading: leftUIView.leadingAnchor,
                              bottom: bottomUIView.topAnchor,
                              trailing: nil,
                              padding: .init(top: 0, left: padding, bottom: 0, right: 0),
                              size: .init(width: 0, height: 0))
        previewTrailingAnchor = previewUILabel.trailingAnchor.constraint(equalTo: postUIImageView.leadingAnchor)
        previewTrailingAnchor.isActive = true
        
        authorUILabel.anchor(top: nil,
                             leading: leftUIView.leadingAnchor,
                             bottom: leftUIView.bottomAnchor,
                             trailing: nil,
                             padding: .init(top: 0, left: padding, bottom: padding, right: 0),
                             size: .init(width: 0, height: 0))
        bottomUIView.anchor(top: nil,
                            leading: nil,
                            bottom: leftUIView.bottomAnchor,
                            trailing: postUIImageView.leadingAnchor,
                            padding: .init(top: 0, left: 0, bottom: padding, right: 0),
                            size: .init(width: contentView.frame.width / 2 , height: rowHeight))
    
        ///finish up by adding views to the content view
        [leftUIView,separatorLine].forEach({contentView.addSubview($0)})
        leftUIView.anchor(top: contentView.safeAreaLayoutGuide.topAnchor,
                          leading: contentView.safeAreaLayoutGuide.leadingAnchor,
                          bottom: separatorLine.topAnchor,
                          trailing: contentView.safeAreaLayoutGuide.trailingAnchor,
                          padding: .init(top: 0, left: 0, bottom: 0, right: 0),
                          size: .init(width: 0, height: 0))
        separatorLine.anchor(top: nil,
                          leading: contentView.safeAreaLayoutGuide.leadingAnchor,
                          bottom: contentView.safeAreaLayoutGuide.bottomAnchor,
                          trailing: contentView.safeAreaLayoutGuide.trailingAnchor,
                          padding: .init(top: 0, left: 0, bottom: 0, right: 0),
                          size: .init(width: 0, height: 1))
    
    }
    /// changes constraints so that main view takes extra space
    func noImageViewConstraints(){
        previewTrailingAnchor.isActive = false
        previewTrailingAnchor = previewUILabel.trailingAnchor.constraint(equalTo: leftUIView.trailingAnchor)
        previewTrailingAnchor.isActive = true
        postUIImageView.isHidden = true
//        contentView.layoutIfNeeded()
    }
    /// changes constraints so that there is room for the image
    func withImageViewConstraints(){
        previewTrailingAnchor.isActive = false
        previewTrailingAnchor = previewUILabel.trailingAnchor.constraint(equalTo: postUIImageView.leadingAnchor)
        previewTrailingAnchor.isActive = true
        postUIImageView.isHidden = false
//        contentView.layoutIfNeeded()
    }
}
extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?,
                leading:NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                trailing: NSLayoutXAxisAnchor?,
                padding: UIEdgeInsets = .zero,
                size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
