//
//  NewCommentUIView.swift
//  testing
//
//  Created by Radomyr Bezghin on 9/5/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

class NewCommentView: UIView {
    var commentTextViewHeightConstraint: NSLayoutConstraint? // used to make textview's height adjustable accoring to how much text there is
    private let symbolsConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .light, scale: .default)
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: 0.0))
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    let commentTextView: UITextView = {
       let text = UITextView()
       return text
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "REPLY TICKET"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 1
        return label
    }()
     lazy var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "xmark")?.withConfiguration(symbolsConfig).withTintColor(.lightGray, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    private lazy var authorView: UIImageView = {
        let iv = UIImageView() 
        iv.image = (UIImage(systemName: "person.circle")?.withConfiguration(symbolsConfig).withTintColor(.black, renderingMode: .alwaysOriginal))
        return iv
    }()
    let anonimousSwitch: UISwitch = {
        let sw = UISwitch()
        sw.transform = CGAffineTransform(scaleX: 0.75, y: 0.75);
        return sw
    }()
    private lazy var attachButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "paperclip")?.withConfiguration(symbolsConfig).withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    private lazy var addImageButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "photo")?.withConfiguration(symbolsConfig).withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    let sendButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(" SEND ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.clipsToBounds = true
        return button
    }()
    private func setupViews(){
        self.backgroundColor = .white
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 5
        [titleLabel,closeButton,commentTextView, authorView, anonimousSwitch, attachButton, addImageButton, sendButton].forEach {self.addSubview($0)}
        self.addSubview(commentTextView)
        
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.addAnchors(top: self.topAnchor,
                                 leading: nil,
                                 bottom: nil,
                                 trailing: nil,
                                 padding: .init(top: Constants.standardPadding, left: 0, bottom: 0, right: 0))
        
        closeButton.addAnchors(top: self.topAnchor,
                                 leading: self.leadingAnchor,
                                 bottom: nil,
                                 trailing: nil,
                                 padding: .init(top: Constants.standardPadding, left: Constants.standardPadding, bottom: 0, right: 0))
 
        commentTextView.addAnchors(top: closeButton.bottomAnchor,
                                 leading: self.leadingAnchor,
                                 bottom: anonimousSwitch.topAnchor,
                                 trailing: self.trailingAnchor,
                                 padding: .init(top: Constants.standardPadding, left: Constants.standardPadding, bottom: 0, right: Constants.standardPadding),
                                 size: .init(width: 0, height: 0))

        commentTextViewHeightConstraint = commentTextView.heightAnchor.constraint(equalToConstant: 0)
        commentTextViewHeightConstraint?.isActive = true
        
        authorView.addAnchors(top: nil,
                                 leading: self.leadingAnchor,
                                 bottom: nil,
                                 trailing: nil,
                                 padding: .init(top: 0, left: Constants.standardPadding, bottom: 0, right: 0))
        authorView.centerYAnchor.constraint(equalTo: anonimousSwitch.centerYAnchor).isActive = true
        anonimousSwitch.addAnchors(top: nil,
                                 leading: authorView.trailingAnchor,
                                 bottom: self.bottomAnchor,
                                 trailing: nil,
                                 padding: .init(top: 0, left: Constants.standardPadding, bottom: Constants.standardPadding/2, right: 0))
        
        attachButton.addAnchors(top: nil,
                                 leading: nil,
                                 bottom: nil,
                                 trailing: addImageButton.leadingAnchor,
                                 padding: .init(top: 0, left: 0, bottom: 0, right: Constants.standardPadding),
                                 size: .init(width: 0, height: anonimousSwitch.frame.height))
        attachButton.centerYAnchor.constraint(equalTo: anonimousSwitch.centerYAnchor).isActive = true
        addImageButton.addAnchors(top: nil,
                                 leading: nil,
                                 bottom: nil,
                                 trailing: sendButton.leadingAnchor,
                                 padding: .init(top: 0, left: 0, bottom: 0, right: Constants.standardPadding))
        addImageButton.centerYAnchor.constraint(equalTo: anonimousSwitch.centerYAnchor).isActive = true
        sendButton.addAnchors(top: nil,
                                 leading: nil,
                                 bottom: nil,
                                 trailing: self.trailingAnchor,
                                 padding: .init(top: 0, left: 0, bottom: 0, right: Constants.standardPadding))
        sendButton.centerYAnchor.constraint(equalTo: anonimousSwitch.centerYAnchor).isActive = true

    }
}
