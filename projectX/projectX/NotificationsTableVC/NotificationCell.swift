//
//  NotificationCell.swift
//  projectX
//
//  Created by Gurpreet Dhillon on 9/7/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//
import UIKit

class NotificationCell: UITableViewCell {
    
    
    static let CellID = "NotificationCell"
    
    let padding:CGFloat = 5
    let rowHeight:CGFloat = 18
    
    let dateUILabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .left
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let previewtxtLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let notifimage: UIImageView = {
        let label = UIImageView()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        
        [dateUILabel, previewtxtLabel, notifimage].forEach {contentView.addSubview($0)}
       
        
    
        
        previewtxtLabel.addAnchors(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: dateUILabel.topAnchor, trailing: contentView.trailingAnchor,
                                          padding: .init(top: padding + 20, left: 70, bottom: padding + 10, right: 3),
               size: .init(width: 0, height: 0))
               
        notifimage.addAnchors(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: nil,
                              padding: .init(top: padding + 15, left: 10, bottom: 0, right: 0),
               size: .init(width: 50, height: 50))
               
               // center pic = (70/2) - (50/2)
               
               dateUILabel.addAnchors(top: previewtxtLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: nil,
               padding: .init(top: padding, left: 70, bottom: padding, right: 0),
               size: .init(width: 0, height: 0))
        
}
}
