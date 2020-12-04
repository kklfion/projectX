//
//  View.swift
//  testing
//
//  Created by Radomyr Bezghin on 8/19/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

class PostView: UIView {
    
    var imageHeightConstaint: NSLayoutConstraint! //if image is nil we want imageview to have height of zero
 
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: 0.0))
        setupViews(viewFrame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    //shadow is added to the container
    let shadowLayerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.2
        return view
    }()
    //container contains all the stacks
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white//Constants.backgroundColor //
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    //MARK: top view
    //holds view above the comment section
    let topViewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
     let authorUILabel: UILabel = {
       let label = UILabel()
        label.font = Constants.smallerTextFont
       label.textColor = .lightGray
       label.numberOfLines = 1
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
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
     let titleUILabel: UILabel = {
       let label = UILabel()
        label.font = Constants.headlineTextFont
       label.numberOfLines = 0
       label.adjustsFontSizeToFitWidth = false
       label.lineBreakMode = .byTruncatingTail
       label.textColor = .black
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
     let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
     let bodyUILabel: UILabel = {
       let text = UILabel()
        text.font = Constants.bodyTextFont
       text.numberOfLines = 0
       text.adjustsFontSizeToFitWidth = false
       text.lineBreakMode = .byTruncatingTail
       text.textColor = .black
       text.translatesAutoresizingMaskIntoConstraints = false
       return text
    }()
    let authorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "sslug")
        
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.layer.cornerRadius = 15
        
        return imageView
    }()
    let authorLabel: UILabel = {
        let label = UILabel()
        label.text = "u/Sammy"
        label.font = Constants.smallerTextFont
        label.textColor = .lightGray
        label.numberOfLines = 1
        return label
    }()
    let likeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "heart")?.withTintColor(Constants.redColor, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    let likesLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .black
        label.textAlignment = .left
        label.font = Constants.smallerTextFont
        label.numberOfLines = 1
        return label
    }()
    let commentsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "bubble.right.fill")?.withTintColor(Constants.redColor, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "1"
        label.font = Constants.smallerTextFont
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    //MARK: button handlers
    @objc func dislikeButtonTouched(){
        if let likesCount = Int(likesLabel.text ?? "0"){
            likesLabel.text = "\(likesCount - 1)"
        }
    }
    @objc func likeButtonTouched(){
        if let likesCount = Int(likesLabel.text ?? "0"){
            likesLabel.text = "\(likesCount + 1)"
        }
    }
    
    private func setupViews(viewFrame: CGRect? = nil){
        let size = viewFrame ?? CGRect(x: 0, y: 0, width: 0, height: 0)
        self.backgroundColor = .white
        self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        
        let authorStack = UIStackView(arrangedSubviews: [authorImageView, authorLabel])
        authorStack.axis = .horizontal
        authorStack.spacing = 10
        //authorStack.backgroundColor = .yellow
        
        let likesCommentsStack = UIStackView(arrangedSubviews: [likeButton, likesLabel, commentsButton, commentsLabel])
        likesCommentsStack.axis = .horizontal
        likesCommentsStack.spacing = 10
        likesCommentsStack.distribution = .fillEqually
        //likesCommentsStack.backgroundColor = .green
        
        let bottomStack = UIStackView(arrangedSubviews: [authorStack, likesCommentsStack])
        bottomStack.axis = .horizontal
        bottomStack.distribution = .fillEqually
        bottomStack.spacing = 10
        
        [authorUILabel, dateUILabel, titleUILabel, postImageView, bodyUILabel, bottomStack].forEach {containerView.addSubview($0)}
        

        authorUILabel.addAnchors(top: containerView.topAnchor,
                                 leading: containerView.leadingAnchor,
                                 bottom: nil,
                                 trailing: nil,
                                 padding: .init(top: Constants.standardPadding, left: Constants.standardPadding, bottom: 0, right: 0),
                                 size: .init(width: 0, height: 0))
        dateUILabel.addAnchors(
                                top: containerView.topAnchor,
                                leading: authorUILabel.trailingAnchor,
                                bottom: nil,
                                trailing: nil,
                                padding: .init(top: Constants.standardPadding, left: Constants.standardPadding, bottom: 0, right: 0),
                                size: .init(width: 0, height: 0))
        
        
        titleUILabel.addAnchors(top: authorUILabel.bottomAnchor,
                                leading: containerView.leadingAnchor,
                                bottom: nil,
                                trailing: containerView.trailingAnchor,
                                padding: .init(top: 0, left: Constants.standardPadding, bottom: 0, right: Constants.standardPadding ))
        
        postImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        postImageView.addAnchors(top: titleUILabel.bottomAnchor,
                                leading: nil,
                                bottom: nil,
                                trailing: nil,
                                padding: .init(top: Constants.standardPadding, left: 0, bottom: 0, right: 0),
                                size: .init(width: size.width, height: 0))
        imageHeightConstaint = postImageView.heightAnchor.constraint(equalToConstant: size.width * 0.7)
        imageHeightConstaint.isActive = true
        
        bodyUILabel.addAnchors(top: postImageView.bottomAnchor,
                               leading: containerView.leadingAnchor,
                               bottom: nil,
                               trailing: containerView.trailingAnchor,
                               padding: .init(top: Constants.standardPadding, left: Constants.standardPadding, bottom: 0, right: Constants.standardPadding))
        bottomStack.addAnchors(top: bodyUILabel.bottomAnchor,
                                  leading: containerView.leadingAnchor,
                                  bottom: containerView.bottomAnchor,
                                  trailing: containerView.trailingAnchor,
                                  padding: .init(top: Constants.standardPadding, left: Constants.standardPadding, bottom: 0, right: 0))
        
        
        ///finish up by adding views to the content view
        [shadowLayerView,containerView].forEach({self.addSubview($0)})
        containerView.addAnchors(top: self.safeAreaLayoutGuide.topAnchor,
                          leading: self.safeAreaLayoutGuide.leadingAnchor,
                          bottom: self.safeAreaLayoutGuide.bottomAnchor,
                          trailing: self.safeAreaLayoutGuide.trailingAnchor,
                          padding: .init(top: 10, left: 10, bottom: 10, right: 10),
                          size: .init(width: 0, height: 0))
        shadowLayerView.addAnchors(top: self.safeAreaLayoutGuide.topAnchor,
                          leading: self.safeAreaLayoutGuide.leadingAnchor,
                          bottom: self.safeAreaLayoutGuide.bottomAnchor,
                          trailing: self.safeAreaLayoutGuide.trailingAnchor,
                          padding: .init(top: 10, left: 10, bottom: 10, right: 10),
                          size: .init(width: 0, height: 0))
    }
}
