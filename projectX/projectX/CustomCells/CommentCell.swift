//
//  CommentTableViewCell.swift
//  testing
//
//  Created by Radomyr Bezghin on 9/9/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

protocol CommentCellTapableDelegate{
    /// returns index of a cell that was tapped
    func didTapLikeButton(_ indexPath: IndexPath, _ cell: CommentCell)
    /// returns index of a cell that was tapped
    func didTapAuthorLabel(_ indexPath: IndexPath)
    /// returns index of a cell that was tapped
}

class CommentCell: UITableViewCell, LikeableCellProtocol {
    
    var indexPath: IndexPath?
    
    var isLiked = false {
        didSet{
            if isLiked{
                likeButton.setImage(UIImage(systemName: "heart.fill")?.withTintColor(Constants.Colors.buttonsRed, renderingMode: .alwaysOriginal), for: .normal)
            }else{
                likeButton.setImage(UIImage(systemName: "heart")?.withTintColor(Constants.Colors.buttonsRed, renderingMode: .alwaysOriginal), for: .normal)
            }
        }
    }
    var delegate: CommentCellTapableDelegate?

    static let cellID = "CommentTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = Constants.Colors.mainBackground
        backgroundColor = .clear
        setupContentView()
        setupButtons()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupContentView()
    }
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
    let authorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        //imageView.image = UIImage(named: "sslug")
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
    let dateTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "1h"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .right
        label.textColor = Constants.Colors.subText
        return label
    }()
    let commentLabel: UILabel = {
        let text = UILabel()
        text.font = UIFont.preferredFont(forTextStyle: .callout)
        text.numberOfLines = 0
        text.adjustsFontSizeToFitWidth = false
        text.lineBreakMode = .byTruncatingTail
        text.text = "i am autoresizing text cell i am autoresizing text cell i am autoresizing text cell i am autoresizing text cell i am autoresizing text cell i am autoresizing text cell  "
        text.textColor = Constants.Colors.mainText
        return text
    }()
    let likeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "heart")?.withTintColor(Constants.Colors.buttonsRed, renderingMode: .alwaysOriginal), for: .normal)
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
    
    private func setupButtons(){
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        let authorTap = UITapGestureRecognizer(target: self, action: #selector(didTapAuthorLabel))
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(didTapAuthorLabel))
        authorImageView.isUserInteractionEnabled = true
        authorLabel.isUserInteractionEnabled = true
        authorLabel.addGestureRecognizer(authorTap)
        authorImageView.addGestureRecognizer(imageTap)
    }
    
    private func  setupContentView(){
        
        let authorStack = UIStackView(arrangedSubviews: [authorImageView, authorLabel])
        authorStack.axis = .horizontal
        authorStack.spacing = 10
        authorStack.alignment = .center
        
//        let likesCommentsStack = UIStackView(arrangedSubviews: [likeButton, likesLabel])
//        likesCommentsStack.axis = .horizontal
//        likesCommentsStack.backgroundColor = .blue
//        likesCommentsStack.spacing = 10
//        //likesCommentsStack.distribution = .fillEqually
//        likeButton.
        
        let bottomStack = UIStackView(arrangedSubviews: [authorStack, likeButton, likesLabel]) //likesCommentsStack
        bottomStack.axis = .horizontal
        //bottomStack.distribution = .fillEqually
        bottomStack.spacing = 20
   
        //MAIN stack, all stacks come in this stack
        let stack = UIStackView(arrangedSubviews: [commentLabel, bottomStack])
        stack.spacing = 10
        stack.axis = .vertical
        //stack.alignment = .center
        
        [stack].forEach { containerView.addSubview($0) }
        stack.addAnchors(top: containerView.topAnchor,
                         leading: containerView.leadingAnchor,
                         bottom: containerView.bottomAnchor,
                         trailing: containerView.trailingAnchor,
                         padding: .init(top: 10, left: 10, bottom: 10, right: 10),
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
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            self.shadowLayerView.layer.shadowColor = Constants.Colors.shadow.cgColor
        }
    }

}
extension CommentCell{
    @objc func didTapAuthorLabel( ) {
        guard let indexPath = indexPath else{return}
        self.delegate?.didTapAuthorLabel(indexPath)
    }
    @objc func didTapLikeButton() {
        guard let indexPath = indexPath else{return}
        self.delegate?.didTapLikeButton(indexPath, self)
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
