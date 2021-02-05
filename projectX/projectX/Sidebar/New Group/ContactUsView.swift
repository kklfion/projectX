//
//  ContactUsView.swift
//  projectX
//
//  Created by Gurpreet Dhillon on 1/26/21.
//  Copyright © 2021 Radomyr Bezghin. All rights reserved.
//

import Foundation
import UIKit


class ContactUsView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    let title:CGFloat = 22
    let titleType:UIFont.Weight = .heavy
    
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    lazy var contactUs: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: title,weight: titleType)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.text = "Contact Us"
        return label
    }()
    lazy var No1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = "For general inquiries, complaints, questions or claims concerning the licensed Application, please contact: appdevucsc2020@gmail.com, Instagram: @necto_uc"
        return label
    }()
    private func setupViews(){
        self.backgroundColor = .white
        
        self.addSubview(cancelButton)
        self.addSubview(contactUs)
        self.addSubview(No1)
        cancelButton.addAnchors(top: self.safeAreaLayoutGuide.topAnchor,
                                leading: nil,
                                bottom: nil,
                                trailing: self.safeAreaLayoutGuide.trailingAnchor,
                                padding: .init(top: 10, left: 0, bottom: 0, right: 10))
        contactUs.addAnchors(top: cancelButton.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 10, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No1.addAnchors(top: contactUs.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 15, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        
        
    }
    
    
}
