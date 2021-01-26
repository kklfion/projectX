//
//  TermsOfServiceView.swift
//  projectX
//
//  Created by Gurpreet Dhillon on 1/25/21.
//  Copyright © 2021 Radomyr Bezghin. All rights reserved.
//
import UIKit
import Foundation


class TermsOfServiceView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    let tosTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20,weight: .bold)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.text = "END USER LICENSE AGREEMENT"
        return label
    }()
    let effectiveDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.text = "Last updated January 24, 2021"
        return label
    }()
    let Intro: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "Necto is licensed to You (End-User) by Project Necto, located at, UC Santa Cruz, California, United States (hereinafter: Licensor), for use only under the terms of this License Agreement. By downloading the Application from the Apple AppStore, and any update thereto (as permitted by this License Agreement), You indicate that You agree to be bound by all of the terms and conditions of this License Agreement, and that You accept this License Agreement. The parties of this License Agreement acknowledge that Apple is not a Party to this License Agreement and is not bound by any provisions or obligations with regard to the Application, such as warranty, liability, maintenance and support thereof. Necto, not Apple, is solely responsible for the licensed Application and the content thereof. This License Agreement may not provide for usage rules for the Application that are in conflict with the latest App Store Terms of Service. Necto acknowledges that it had the opportunity to review said terms and this License Agreement is not conflicting with them. All rights not expressly granted to You are reserved."
        return label
    }()
    private func setupViews(){
        self.backgroundColor = .white
        self.addSubview(cancelButton)
        self.addSubview(tosTitle)
        self.addSubview(effectiveDate)
        self.addSubview(Intro)
        cancelButton.addAnchors(top: self.safeAreaLayoutGuide.topAnchor,
                                leading: nil,
                                bottom: nil,
                                trailing: self.safeAreaLayoutGuide.trailingAnchor,
                                padding: .init(top: 10, left: 0, bottom: 0, right: 10))
        tosTitle.addAnchors(top: cancelButton.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 10, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        effectiveDate.addAnchors(top: tosTitle.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 10, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
       Intro.addAnchors(top: effectiveDate.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 10, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
    
    }
    
}
