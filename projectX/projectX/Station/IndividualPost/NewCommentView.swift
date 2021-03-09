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
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    //shadow is added to the container
    let shadowLayerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 15
        view.layer.shadowColor = Constants.Colors.shadow.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.4
        return view
    }()
    //container contains all the stacks
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.mainBackground
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    let commentPlaceholderMessage = "Add comment..."
    lazy var commentTextView: UITextView = {
        let textView = UITextView()
        textView.text = commentPlaceholderMessage
        textView.textAlignment = .center
        textView.textColor = Constants.Colors.subText
        textView.font = Constants.bodyTextFont
        textView.sizeToFit()
        return textView
    }()
     lazy var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "xmark")?.withConfiguration(symbolsConfig).withTintColor(Constants.Colors.darkBrown, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    lazy var authorView: UIImageView = {
        let iv = UIImageView() 
        iv.image = (UIImage(systemName: "person.circle")?.withConfiguration(symbolsConfig).withTintColor(Constants.Colors.darkBrown, renderingMode: .alwaysOriginal))
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    var anonimousSwitch: UISwitch = {
        let sw = UISwitch()
        sw.transform = CGAffineTransform(scaleX: 0.75, y: 0.75);
        return sw
    }()
    lazy var sendButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "paperplane")?.withConfiguration(symbolsConfig).withTintColor(Constants.Colors.darkBrown, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    
    var bottomStack = UIStackView()
    var topStack = UIStackView()
    
    private func setupViews(){
        
        topStack = UIStackView(arrangedSubviews: [closeButton, UIView()])
        topStack.axis = .horizontal
        topStack.spacing = 10
        topStack.isHidden = true
        
        let size: CGFloat = 25.0
        authorView.heightAnchor.constraint(equalToConstant: size).isActive = true
        authorView.widthAnchor.constraint(equalToConstant: size).isActive = true
        authorView.layer.cornerRadius = size/2
        let authorStack = UIStackView(arrangedSubviews: [authorView, anonimousSwitch, UIView()])
        authorStack.axis = .horizontal
        authorStack.spacing = 10
        
        let sendAttachImageStack = UIStackView(arrangedSubviews: [UIView(), sendButton])
        sendAttachImageStack.axis = .horizontal
        sendAttachImageStack.spacing = 10
        
        bottomStack = UIStackView(arrangedSubviews: [authorStack, sendAttachImageStack])
        bottomStack.axis = .horizontal
        bottomStack.spacing = 10
        bottomStack.isHidden = true
        
        let verticalStack = UIStackView(arrangedSubviews: [topStack, commentTextView, bottomStack])
        verticalStack.axis = .vertical
        verticalStack.spacing = 10

        
        [verticalStack].forEach {containerView.addSubview($0)}
        verticalStack.addAnchors(top: containerView.topAnchor,
                                 leading: containerView.leadingAnchor,
                                 bottom: containerView.bottomAnchor,
                                 trailing: containerView.trailingAnchor,
                                 padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        
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
    func setCommentViewDefaltMessage(){
        commentTextView.text = commentPlaceholderMessage
        commentTextView.textAlignment = .center
        commentTextView.textColor = Constants.Colors.subText
    }
    func setAnonimousImage(){
        authorView.image = (UIImage(systemName: "person.crop.circle.fill")?.withTintColor(Constants.Colors.darkBrown, renderingMode: .alwaysOriginal))
    }
}
