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
    
    var UID: String?
    
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
        label.textAlignment = .right
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let channelUIButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Food", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let titleUILabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let previewUILabel: UILabel = {
        let text = UILabel()
        text.numberOfLines = 0
        text.text = "Preview"
        text.textColor = .black
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    let bottomUIView: UIView = {
        let stack = UIView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let authorUILabel: UILabel = {
        let label = UILabel()
        label.text = "u/Sammy"
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let heartUIButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "post_heart_icon"), for: .normal)
        button.imageView?.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let likesUILabel: UILabel = {
        let label = UILabel()
        label.text = "13"
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let commentsUIButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "post_comment_icon"), for: .normal)
        button.imageView?.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let commentsUILabel: UILabel = {
        let label = UILabel()
        label.text = "3"
        label.textAlignment = .right
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
        imageView.image = UIImage(named: "post_image_icon")
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
        /// setting up left side of the post
        leftUIView.addSubview(dateUILabel)
        leftUIView.addSubview(channelUIButton)
        leftUIView.addSubview(titleUILabel)
        leftUIView.addSubview(previewUILabel)
        leftUIView.addSubview(bottomUIView)
                
        dateUILabel.topAnchor.constraint(equalTo: leftUIView.topAnchor, constant: 10).isActive = true
        dateUILabel.trailingAnchor.constraint(equalTo: channelUIButton.leadingAnchor, constant: -10).isActive = true
        dateUILabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        dateUILabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        channelUIButton.topAnchor.constraint(equalTo: leftUIView.topAnchor, constant: 10).isActive = true
        channelUIButton.trailingAnchor.constraint(equalTo: leftUIView.trailingAnchor, constant: -10).isActive = true
        channelUIButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        channelUIButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        titleUILabel.topAnchor.constraint(equalTo: dateUILabel.bottomAnchor).isActive = true
        titleUILabel.leadingAnchor.constraint(equalTo: leftUIView.leadingAnchor, constant: 10).isActive = true
        titleUILabel.trailingAnchor.constraint(equalTo: leftUIView.trailingAnchor, constant: -10).isActive = true
        titleUILabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        previewUILabel.topAnchor.constraint(equalTo: titleUILabel.bottomAnchor).isActive = true
        previewUILabel.leadingAnchor.constraint(equalTo: leftUIView.leadingAnchor, constant: 10).isActive = true
        previewUILabel.trailingAnchor.constraint(equalTo: leftUIView.trailingAnchor, constant: -10).isActive = true
        //previewUILabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        previewUILabel.bottomAnchor.constraint(equalTo: bottomUIView.topAnchor).isActive = true
        
        //bottomUIStackView.topAnchor.constraint(equalTo: previewUILabel.bottomAnchor).isActive = true
        bottomUIView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        bottomUIView.leadingAnchor.constraint(equalTo: leftUIView.leadingAnchor, constant: 10).isActive = true
        bottomUIView.trailingAnchor.constraint(equalTo: leftUIView.trailingAnchor, constant: -10).isActive = true
        bottomUIView.bottomAnchor.constraint(equalTo: leftUIView.bottomAnchor).isActive = true
        
        /// set bottom stack view of theq left side
        bottomUIView.addSubview(authorUILabel)
        bottomUIView.addSubview(heartUIButton)
        bottomUIView.addSubview(likesUILabel)
        bottomUIView.addSubview(commentsUIButton)
        bottomUIView.addSubview(commentsUILabel)
        
        authorUILabel.topAnchor.constraint(equalTo: bottomUIView.topAnchor).isActive = true
        authorUILabel.bottomAnchor.constraint(equalTo: bottomUIView.bottomAnchor).isActive = true
        authorUILabel.leadingAnchor.constraint(equalTo: bottomUIView.leadingAnchor).isActive = true
        authorUILabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        //heartUIButton.topAnchor.constraint(equalTo: bottomUIView.topAnchor).isActive = true
        heartUIButton.bottomAnchor.constraint(equalTo: bottomUIView.bottomAnchor,constant:  -5).isActive = true
        heartUIButton.trailingAnchor.constraint(equalTo: likesUILabel.leadingAnchor, constant: -10).isActive = true
        heartUIButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        heartUIButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        likesUILabel.topAnchor.constraint(equalTo: bottomUIView.topAnchor).isActive = true
        likesUILabel.bottomAnchor.constraint(equalTo: bottomUIView.bottomAnchor).isActive = true
        likesUILabel.trailingAnchor.constraint(equalTo: commentsUIButton.leadingAnchor, constant: -10).isActive = true
        likesUILabel.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        //commentsUIButton.topAnchor.constraint(equalTo: bottomUIView.topAnchor).isActive = true
        commentsUIButton.bottomAnchor.constraint(equalTo: bottomUIView.bottomAnchor, constant: -5).isActive = true
        commentsUIButton.trailingAnchor.constraint(equalTo: commentsUILabel.leadingAnchor, constant: -10).isActive = true
        commentsUIButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        commentsUIButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        commentsUILabel.topAnchor.constraint(equalTo: bottomUIView.topAnchor).isActive = true
        commentsUILabel.bottomAnchor.constraint(equalTo: bottomUIView.bottomAnchor).isActive = true
        commentsUILabel.trailingAnchor.constraint(equalTo: bottomUIView.trailingAnchor).isActive = true
        commentsUILabel.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        /// setting up right side of the post
        rightUIView.addSubview(postUIImageView)
        
        postUIImageView.topAnchor.constraint(equalTo: rightUIView.topAnchor, constant: 10).isActive = true
        postUIImageView.bottomAnchor.constraint(equalTo: rightUIView.bottomAnchor, constant: -10).isActive = true
        postUIImageView.trailingAnchor.constraint(equalTo: rightUIView.trailingAnchor, constant: -10).isActive = true
        postUIImageView.leadingAnchor.constraint(equalTo:  rightUIView.leadingAnchor).isActive = true
        
        
        ///finish up by adding views to the content view
        contentView.addSubview(leftUIView)
        contentView.addSubview(rightUIView)
        contentView.addSubview(separatorLine)
        
        leftUIView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        leftUIView.trailingAnchor.constraint(equalTo: rightUIView.leadingAnchor).isActive = true
        leftUIView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        leftUIView.bottomAnchor.constraint(equalTo: separatorLine.topAnchor).isActive = true
        
        rightUIView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        rightUIView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        rightUIView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        rightUIView.bottomAnchor.constraint(equalTo: separatorLine.topAnchor).isActive = true
        
        separatorLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        separatorLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        separatorLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        separatorLine.heightAnchor.constraint(equalToConstant: 5).isActive = true
        
        
    }
}
