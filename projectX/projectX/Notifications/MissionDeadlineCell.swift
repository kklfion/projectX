//
//  MissionCell.swift
//  projectX
//
//  Created by Kirill on 9/24/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import Foundation

import UIKit

class MissionCell: UICollectionViewCell {
    
    static let CellID = "MissionDeadlineCell"
    
    let padding:CGFloat = 5
    let rowHeight:CGFloat = 18
        
    let deadlineLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let previewtxtLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let missionImage: UIImageView = {
        let img = UIImageView()
        img.layer.borderWidth = 1
        img.layer.borderColor = UIColor.black.cgColor
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10

        self.contentView.addSubview(deadlineLabel)
        self.contentView.addSubview(previewtxtLabel)
        self.contentView.addSubview(missionImage)
        
        let imgScale: CGFloat = 0.65
        
        self.missionImage.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        self.missionImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: -15).isActive = true
        self.missionImage.widthAnchor.constraint(
            lessThanOrEqualTo: self.contentView.widthAnchor, multiplier: imgScale).isActive = true
        self.missionImage.heightAnchor.constraint(
            lessThanOrEqualTo: self.contentView.heightAnchor, multiplier: imgScale).isActive = true
        missionImage.layer.cornerRadius = self.contentView.frame.width * (imgScale / 2)
        
        self.deadlineLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.deadlineLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.deadlineLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
        self.deadlineLabel.heightAnchor.constraint(
            equalTo: self.contentView.heightAnchor, multiplier: (1 - imgScale) / 4).isActive = true
        
        self.previewtxtLabel.bottomAnchor.constraint(equalTo: deadlineLabel.topAnchor).isActive = true
        self.previewtxtLabel.topAnchor.constraint(equalTo: missionImage.bottomAnchor).isActive = true
        self.previewtxtLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.previewtxtLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
