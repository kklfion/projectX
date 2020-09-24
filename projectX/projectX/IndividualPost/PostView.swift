//
//  View.swift
//  testing
//
//  Created by Radomyr Bezghin on 8/19/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

/*
 View outline
 
 Nav bar with back button Title
 
 TOP View
 Username timestamp
 Title
 Image optional
 Body optional
 
 MIDDLE view
 tableview with comments (not nested for now)
 
 BOTTOM
 stackview with 5 buttons
 share, comment, pen?, bookmark, cancel
 comment pullsout an input view and a keyboard
 input view has top left cancel button, top right send button
 bottom left incognito mode onoff, bottom right attach smth or image.
 
*/
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
    //MARK: top view
    //holds view above the comment section
    let topViewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
     let authorUILabel: UILabel = {
       let label = UILabel()
      label.font = UIFont.preferredFont(forTextStyle: .subheadline)
       label.textColor = .lightGray
       label.numberOfLines = 1
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
     let dateUILabel: UILabel = {
       let label = UILabel()
       label.text = "1h"
       label.font = UIFont.preferredFont(forTextStyle: .subheadline)
       label.textAlignment = .right
       label.textColor = .lightGray
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
     let titleUILabel: UILabel = {
       let label = UILabel()
       label.font = UIFont.preferredFont(forTextStyle: .title1)
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
       text.font = UIFont.preferredFont(forTextStyle: .callout)
       text.numberOfLines = 0
       text.adjustsFontSizeToFitWidth = false
       text.lineBreakMode = .byTruncatingTail
       text.textColor = .black
       text.translatesAutoresizingMaskIntoConstraints = false
       return text
    }()
    //MARK: bottom comments labels/buttons
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
     let likeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(likeButtonTouched), for: .touchUpInside)
        return button
    }()
     let likesLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
     let dislikeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(dislikeButtonTouched), for: .touchUpInside)
        return button
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
        
        [likeButton,likesLabel,dislikeButton].forEach({likesStackView.addArrangedSubview($0)})
        [authorUILabel, dateUILabel, titleUILabel, postImageView, bodyUILabel, likesStackView].forEach {self.addSubview($0)}
        

        authorUILabel.addAnchors(top: self.topAnchor,
                                 leading: self.leadingAnchor,
                                 bottom: nil,
                                 trailing: nil,
                                 padding: .init(top: Constants.standardPadding, left: Constants.standardPadding, bottom: 0, right: 0),
                                 size: .init(width: 0, height: 0))
        dateUILabel.addAnchors(
                                top: self.topAnchor,
                                leading: authorUILabel.trailingAnchor,
                                bottom: nil,
                                trailing: nil,
                                padding: .init(top: Constants.standardPadding, left: Constants.standardPadding, bottom: 0, right: 0),
                                size: .init(width: 0, height: 0))
        
        
        titleUILabel.addAnchors(top: authorUILabel.bottomAnchor,
                                leading: self.leadingAnchor,
                                bottom: nil,
                                trailing: self.trailingAnchor,
                                padding: .init(top: 0, left: Constants.standardPadding, bottom: 0, right: Constants.standardPadding ))
        
        postImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        postImageView.addAnchors(top: titleUILabel.bottomAnchor,
                                leading: nil,
                                bottom: nil,
                                trailing: nil,
                                padding: .init(top: Constants.standardPadding, left: 0, bottom: 0, right: 0),
                                size: .init(width: size.width, height: 0))
        imageHeightConstaint = postImageView.heightAnchor.constraint(equalToConstant: size.width * 0.7)
        imageHeightConstaint.isActive = true
        
        bodyUILabel.addAnchors(top: postImageView.bottomAnchor,
                               leading: self.leadingAnchor,
                               bottom: nil,
                               trailing: self.trailingAnchor,
                               padding: .init(top: Constants.standardPadding, left: Constants.standardPadding, bottom: 0, right: Constants.standardPadding))
        likesStackView.addAnchors(top: bodyUILabel.bottomAnchor,
                                  leading: self.leadingAnchor,
                                  bottom: self.bottomAnchor,
                                  trailing: nil,
                                  padding: .init(top: Constants.standardPadding, left: Constants.standardPadding, bottom: 0, right: 0))
    }
}
