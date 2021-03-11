//
//  PostCollectionViewCell.swift
//  projectX
//
//  Created by Radomyr Bezghin on 12/4/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell, LikeableCellProtocol {
    
    static let cellID = "PostCollectionViewCell"
    
    let likeCommentsConfig = UIImage.SymbolConfiguration(pointSize: 17, weight: .ultraLight, scale: .medium)
    
    ///when cell is liked vs disliked UI should be changed as well as likes count
    var isLiked = false {
        didSet{
            if isLiked{
                likeButton.setImage(UIImage(systemName: "heart.fill", withConfiguration: likeCommentsConfig)?.withTintColor(Constants.Colors.buttonsRed, renderingMode: .alwaysOriginal), for: .normal)
            }else{
                likeButton.setImage(UIImage(systemName: "heart", withConfiguration: likeCommentsConfig)?.withTintColor(Constants.Colors.buttonsRed, renderingMode: .alwaysOriginal), for: .normal)
            }
        }
    }
    
    ///to add actions to cell buttons
    weak var delegate: PostCollectionViewCellDidTapDelegate?
    
    ///indexpath to track which cell was tapped
    var indexPath: IndexPath?

    //shadow is added to the container
    let shadowLayerView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.mainBackground
        view.layer.cornerRadius = 5
        view.layer.shadowColor = Constants.Colors.shadow.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.5
        return view
    }()
    //container contains all the stacks
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.secondaryBackground
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "1h"
        label.font = Constants.smallerTextFont
        label.textAlignment = .right
        label.textColor = Constants.Colors.subText
        return label
    }()
    let stationButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Station", for: .normal)
        button.setTitleColor(Constants.Colors.subText, for: .normal)
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
        label.font = Constants.bodyTextFont
        label.numberOfLines = 4
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.textColor = Constants.Colors.mainText
        return label
    }()
    let messageLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.bodyTextFont
        label.numberOfLines = 4
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.textColor = Constants.Colors.mainText
        return label
    }()
    let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()

    let authorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    let authorLabel: UILabel = {
        let label = UILabel()
        label.text = "u/Sammy"
        label.font = Constants.smallerTextFont
        label.textColor = Constants.Colors.subText
        label.numberOfLines = 1
        return label
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "heart", withConfiguration: likeCommentsConfig)?.withTintColor(Constants.Colors.buttonsRed, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    let likesLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.font = Constants.smallerTextFont
        label.numberOfLines = 1
        return label
    }()
    lazy var commentsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "message", withConfiguration: likeCommentsConfig)?.withTintColor(Constants.Colors.buttonsRed, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Constants.smallerTextFont
        label.textColor = Constants.Colors.mainText
        label.numberOfLines = 1
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        setupContentView()
        setupButtons()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    let defaultImageConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .ultraLight)
    func setDefaultPostImage(){
        postImageView.image = UIImage(named: "noImagePostImage")
        //postImageView.image = UIImage(named: "noImagePostImage")?.withRenderingMode(.alwaysTemplate)
        //postImageView.tintColor = Constants.Colors.mainText
    }
    func setPostImage(image: UIImage?){
        postImageView.image = image
    }
    func setAnonymousUser(){
        authorLabel.text =  "Anonymous"
        authorImageView.image = (UIImage(systemName: "person.crop.circle.fill")?.withTintColor(Constants.Colors.darkBrown, renderingMode: .alwaysOriginal))
        authorLabel.isUserInteractionEnabled = false
        authorImageView.isUserInteractionEnabled = false
    }
    private func setupContentView(){
        
        contentView.backgroundColor = .none
        
        let stationDateStack = UIStackView(arrangedSubviews: [dateLabel, stationButton])
        stationDateStack.spacing = 5
        stationDateStack.distribution = .fillEqually
        stationDateStack.axis = .horizontal
        
        let authorStack = UIStackView(arrangedSubviews: [authorImageView, authorLabel])
        authorStack.axis = .horizontal
        authorStack.spacing = 5
        
        let likesCommentsStack = UIStackView(arrangedSubviews: [likeButton, likesLabel, commentsButton, commentsLabel])
        likesCommentsStack.axis = .horizontal
        likesCommentsStack.spacing = 5
        likesCommentsStack.distribution = .fillEqually
        
        let bottomStack = UIStackView(arrangedSubviews: [authorStack, likesCommentsStack])
        bottomStack.axis = .horizontal
        bottomStack.distribution = .fillEqually
        bottomStack.spacing = 10
        
        let leftVerticalStack = UIStackView(arrangedSubviews: [titleLabel, bottomStack])
        leftVerticalStack.spacing = 10
        leftVerticalStack.axis = .vertical
        
        postImageView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        postImageView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        let leftVerticalAndImageStack = UIStackView(arrangedSubviews: [leftVerticalStack, postImageView])
        leftVerticalAndImageStack.axis = .horizontal
        leftVerticalAndImageStack.alignment = .center
        leftVerticalAndImageStack.spacing = 10
        
        //MAIN stack, all stacks come in this stack
        let stack = UIStackView(arrangedSubviews: [stationDateStack ,leftVerticalAndImageStack])
        //stack.spacing = 10
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stack.axis = .vertical
        
        containerView.addSubview(stack)
        stack.addAnchors(top: containerView.topAnchor,
                         leading: containerView.leadingAnchor,
                         bottom: containerView.bottomAnchor,
                         trailing: containerView.trailingAnchor,
                         padding: .init(top: 0, left: 0, bottom: 0, right: 0),
                         size: .init(width: 0, height: 0))
        
        
        ///finish up by adding views to the content view
        [shadowLayerView,containerView].forEach({contentView.addSubview($0)})
        containerView.addAnchors(top: contentView.topAnchor,
                          leading: contentView.leadingAnchor,
                          bottom: contentView.bottomAnchor,
                          trailing: contentView.trailingAnchor,
                          padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        shadowLayerView.addAnchors(top: contentView.topAnchor,
                          leading: contentView.leadingAnchor,
                          bottom: contentView.bottomAnchor,
                          trailing: contentView.trailingAnchor,
                          padding: .init(top: 10, left: 10, bottom: 10, right: 10))
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            self.shadowLayerView.layer.shadowColor = Constants.Colors.shadow.cgColor
        }
    }
}
extension PostCollectionViewCell{
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
        self.delegate?.didTapLikeButton(indexPath, self)
    }
    @objc func didTapCommentsButton() {
        guard let indexPath = indexPath else{return}
        self.delegate?.didTapCommentsButton(indexPath)
    }
    func changeCellToLiked(){
        guard let likesCount = Int(likesLabel.text ?? "") else {return}
        likesLabel.text = "\(likesCount + 1)"
    }
    func changeCellToDisliked(){
        guard let likesCount = Int(likesLabel.text ?? "") else {return}
        likesLabel.text = "\(likesCount - 1)"
    }
}

