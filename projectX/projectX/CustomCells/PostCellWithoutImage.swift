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

class PostCellWithoutImage: UITableViewCell {
    
    static let cellID = "PostCellWithoutImage"
    
    ///to add actions to cell buttons
    weak var delegate: PostCellDidTapDelegate?
    
    ///indexpath to track which cell was tapped
    var indexPath: IndexPath?

    //shadow is added to the container
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
    //container contains all the stacks
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.backgroundColor //.white
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "1h"
        label.font = Constants.smallerTextFont
        label.textAlignment = .right
        label.textColor = .lightGray
        return label
    }()
    let stationButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Station", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = Constants.smallerTextFont
        button.contentHorizontalAlignment = .left
        return button
    }()
    //view for title&message labels
    let textView: UIView = {
        let view = UIView()
        return view
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = Constants.headlineTextFont
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .black
        //label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //label.backgroundColor = .red
        return label
    }()
    let messageLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.bodyTextFont
        label.numberOfLines = 4
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.text = "Preview"
        //label.heightAnchor.constraint(equalToConstant: 100).isActive = true
        label.textColor = .black
        //label.backgroundColor = .blue
        return label
    }()
    let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        return imageView
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
        label.font = Constants.smallerTextFont
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        setupContentView()
        setupButtons()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupContentView()
    }
    private func setupButtons(){
        stationButton.addTarget(self, action: #selector(didTapStationButton), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        commentsButton.addTarget(self, action: #selector(didTapCommentsButton), for: .touchUpInside)
        let authorTap = UITapGestureRecognizer(target: self, action: #selector(didTapAuthorLabel))
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(didTapAuthorLabel))
        authorImageView.isUserInteractionEnabled = true
        authorLabel.isUserInteractionEnabled = true
        authorLabel.addGestureRecognizer(authorTap)
        authorImageView.addGestureRecognizer(imageTap)
    }
    
    private func setupContentView(){
        
        contentView.backgroundColor = .white
        
        let stationDateStack = UIStackView(arrangedSubviews: [dateLabel, stationButton])
        stationDateStack.spacing = 10
        stationDateStack.distribution = .fillEqually
        stationDateStack.axis = .horizontal
        
        textView.addSubview(titleLabel)
        textView.addSubview(messageLabel)
        //TODO: fix this !!!!
        textView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        titleLabel.addAnchors(top: textView.topAnchor,
                                leading: textView.leadingAnchor,
                                bottom: messageLabel.topAnchor,
                                trailing: textView.trailingAnchor,
                                padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        messageLabel.addAnchors(top: titleLabel.bottomAnchor,
                                leading: textView.leadingAnchor,
                                bottom: textView.bottomAnchor,
                                trailing: textView.trailingAnchor,
                                padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        let textImageStack = UIStackView(arrangedSubviews: [textView, postImageView])
        textImageStack.spacing = 10
        textImageStack.axis = .horizontal
        textImageStack.alignment = .center
        
        
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
        
        
        
        //MAIN stack, all stacks come in this stack
        let stack = UIStackView(arrangedSubviews: [stationDateStack, textImageStack, bottomStack])
        stack.spacing = 0
        stack.axis = .vertical
        
        [stack].forEach { containerView.addSubview($0) }
        stack.addAnchors(top: containerView.topAnchor,
                         leading: containerView.leadingAnchor,
                         bottom: containerView.bottomAnchor,
                         trailing: containerView.trailingAnchor,
                         padding: .init(top: 0, left: 10, bottom: 10, right: 10),
                         size: .init(width: 0, height: 0))
        
        
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
extension PostCellWithoutImage{
    @objc func didTapAuthorLabel( ) {
        guard let indexPath = indexPath else{return}
        self.delegate?.didTapAuthorLabel(indexPath)
    }
    @objc func didTapStationButton( ) {
        guard let indexPath = indexPath else{return}
        self.delegate?.didTapStationButton(indexPath)
    }
    @objc func didTapLikeButton() {
        guard let indexPath = indexPath else{return}
        self.delegate?.didTapLikeButton(indexPath)
    }
    @objc func didTapCommentsButton() {
        guard let indexPath = indexPath else{return}
        self.delegate?.didTapCommentsButton(indexPath)
    }
}
