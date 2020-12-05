//
//  MissionsCell.swift
//  projectX
//
//  Created by Kirill on 9/24/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import Foundation

import UIKit

class MissionsCell: UITableViewCell {
    
    
    static let Cell1ID = "MissionsCell"
    
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
    // might make it a uibutton in the future
    let nameUILabel: UILabel = {
       let label = UILabel()
       label.font = UIFont.systemFont(ofSize: 10)
       label.textAlignment = .left
       label.textColor = .lightGray
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    let selectionUILabel: UILabel = { //make into uibutton
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 8)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.cornerRadius = 3
        label.layer.borderWidth = 0.7
        return label
    }()
    let channelUILabel: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 8)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 3
        button.layer.borderWidth = 0.7
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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
        
        [dateUILabel, previewtxtLabel, notifimage, nameUILabel, selectionUILabel, channelUILabel].forEach {contentView.addSubview($0)}
       
        
    
        
        previewtxtLabel.addAnchors(top: channelUILabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: dateUILabel.topAnchor, trailing: contentView.trailingAnchor,
                                          padding: .init(top: padding, left: 70, bottom: padding, right: 3),
               size: .init(width: 0, height: 0))
               
        notifimage.addAnchors(top: channelUILabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: nil,
                              padding: .init(top: 0, left: 10, bottom: padding, right: 0),
               size: .init(width: 50, height: 50))
               
               // center pic = (70/2) - (50/2)
               
        dateUILabel.addAnchors(top: previewtxtLabel.bottomAnchor, leading: nil, bottom: contentView.bottomAnchor, trailing: nil,
               padding: .init(top: padding, left: 0, bottom: padding + 15, right: 0),
               size: .init(width: 0, height: 0))
        
        nameUILabel.addAnchors(top: previewtxtLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: dateUILabel.trailingAnchor,
            padding: .init(top: padding, left: 70, bottom: padding + 15, right: padding + 27),
                               size: .init(width: 0, height: 0))
        
        
        
        // editing with border/color of selection and channel labels with padding needs to be done later
        
        
        //    <-<-
        selectionUILabel.addAnchors(top: contentView.topAnchor, leading: nil, bottom: previewtxtLabel.topAnchor, trailing: contentView.trailingAnchor,
                                    padding: .init(top: padding + 8, left: padding, bottom: 2, right: padding + 10),
                                    size: .init(width: 0, height: 0)
        
        )
        channelUILabel.addAnchors(top: contentView.topAnchor, leading: nil, bottom: previewtxtLabel.topAnchor, trailing: selectionUILabel.leadingAnchor,
                                    padding: .init(top: padding + 8, left: 20, bottom: 2, right: padding),
                                    size: .init(width: 0, height: 0)
        
        )
        
        
        
      //   <-  ->
     /*   selectionUILabel.addAnchors(top: contentView.topAnchor, leading: channelUILabel.trailingAnchor, bottom: previewtxtLabel.topAnchor, trailing: contentView.trailingAnchor,
                                    padding: .init(top: padding + 8, left: padding, bottom: 2, right: padding + 10),
                                    size: .init(width: 0, height: 0)
        
        )
        channelUILabel.addAnchors(top: contentView.topAnchor, leading: nil, bottom: previewtxtLabel.topAnchor, trailing: selectionUILabel.trailingAnchor,
                                    padding: .init(top: padding + 8, left: 20, bottom: 2, right: padding + 45),
                                    size: .init(width: 0, height: 0)
        
        )*/
        
        //   <-  <-
        /*   selectionUILabel.addAnchors(top: contentView.topAnchor, leading: nil, bottom: previewtxtLabel.topAnchor, trailing: contentView.trailingAnchor,
                                       padding: .init(top: padding + 8, left: padding, bottom: 2, right: padding + 10),
                                       size: .init(width: 0, height: 0)
           
           )
           channelUILabel.addAnchors(top: contentView.topAnchor, leading: nil, bottom: previewtxtLabel.topAnchor, trailing: selectionUILabel.trailingAnchor,
                                       padding: .init(top: padding + 8, left: 20, bottom: 2, right: padding + 45),
                                       size: .init(width: 0, height: 0)
           
           )*/
        
        
        
        
        
        
        
        
}
}
