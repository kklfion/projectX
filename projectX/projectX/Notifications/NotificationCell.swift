//
//  NotificationCell.swift
//  projectX
//
//  Created by Kirill on 9/12/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import Foundation

import UIKit

class NotificationCell: UICollectionViewCell {
    
    
    static let CellID = "NotificationCell"
    
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
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.smallerTextFont
        label.textAlignment = .left
        label.textColor = .lightGray
        return label
    }()
    let textLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.bodyTextFont
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    let notificationImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.widthAnchor.constraint(equalToConstant: 50).isActive = true
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        setupContentView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupContentView(){
        
        [dateLabel, textLabel, notificationImageView].forEach {contentView.addSubview($0)}
        let textAndDataStack = UIStackView(arrangedSubviews: [textLabel, dateLabel])
        textAndDataStack.axis = .vertical
        textAndDataStack.spacing = 10
        let textAndImageStack = UIStackView(arrangedSubviews: [notificationImageView, textAndDataStack])
        textAndImageStack.alignment = .center
        textAndImageStack.spacing = 10
        
        [textAndImageStack].forEach { containerView.addSubview($0) }
        textAndImageStack.addAnchors(top: containerView.topAnchor,
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

