//
//  NewCommentUIView.swift
//  testing
//
//  Created by Radomyr Bezghin on 9/5/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

class NewCommentView: UIView {
    //var commentTextViewHeightConstraint: NSLayoutConstraint? // used to make textview's height adjustable accoring to how much text there is
    private let symbolsConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .light, scale: .default)
    
    override init(frame: CGRect) {
        //super.init(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: 0.0))
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    //shadow is added to the container
    let shadowLayerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.4
        return view
    }()
    //container contains all the stacks
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white//Constants.backgroundColor //
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    let commentTextView: UITextView = {
        let text = UITextView()
        text.text = "Add Comment ..."
        text.sizeToFit()
        return text
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
    let sendButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "paperplane"), for: .normal)
        return button
    }()
    private func setupViews(){
        [closeButton,commentTextView, authorView, anonimousSwitch, sendButton].forEach {containerView.addSubview($0)}
        closeButton.addAnchors(top: containerView.topAnchor,
                                 leading: containerView.leadingAnchor,
                                 bottom: nil,
                                 trailing: nil,
                                 padding: .init(top: Constants.standardPadding, left: Constants.standardPadding, bottom: 0, right: 0),
                                 size: .init(width: 0, height: 30))
 
        commentTextView.addAnchors(top: closeButton.bottomAnchor,
                                 leading: containerView.leadingAnchor,
                                 bottom: anonimousSwitch.topAnchor,
                                 trailing: containerView.trailingAnchor,
                                 padding: .init(top: Constants.standardPadding, left: Constants.standardPadding, bottom: 0, right: Constants.standardPadding),
                                 size: .init(width: 0, height: 0))

//        commentTextViewHeightConstraint = commentTextView.heightAnchor.constraint(equalToConstant: 0)
//        commentTextViewHeightConstraint?.isActive = true
        
        authorView.addAnchors(top: nil,
                                 leading: containerView.leadingAnchor,
                                 bottom: nil,
                                 trailing: nil,
                                 padding: .init(top: 0, left: Constants.standardPadding, bottom: 0, right: 0))
        authorView.centerYAnchor.constraint(equalTo: anonimousSwitch.centerYAnchor).isActive = true
        anonimousSwitch.addAnchors(top: nil,
                                 leading: authorView.trailingAnchor,
                                 bottom: containerView.bottomAnchor,
                                 trailing: nil,
                                 padding: .init(top: 0, left: Constants.standardPadding, bottom: 30, right: 0))
        sendButton.addAnchors(top: nil,
                                 leading: nil,
                                 bottom: nil,
                                 trailing: containerView.trailingAnchor,
                                 padding: .init(top: 0, left: 0, bottom: 0, right: Constants.standardPadding))
        sendButton.centerYAnchor.constraint(equalTo: anonimousSwitch.centerYAnchor).isActive = true
        
        
        ///finish up by adding views to the content view
        [shadowLayerView,containerView].forEach({self.addSubview($0)})
        containerView.addAnchors(top: self.topAnchor,
                          leading: self.leadingAnchor,
                          bottom: self.bottomAnchor,
                          trailing: self.trailingAnchor,
                          padding: .init(top: 0, left: 0, bottom: 0, right: 0),
                          size: .init(width: 0, height: 0))
        shadowLayerView.addAnchors(top: self.topAnchor,
                          leading: self.leadingAnchor,
                          bottom: self.bottomAnchor,
                          trailing: self.trailingAnchor,
                          padding: .init(top: 0, left: 0, bottom: 0, right: 0),
                          size: .init(width: 0, height: 0))

    }
}
