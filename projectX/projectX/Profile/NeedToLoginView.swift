//
//  NeedToLoginView.swift
//  projectX
//
//  Created by Radomyr Bezghin on 2/4/21.
//  Copyright © 2021 Radomyr Bezghin. All rights reserved.
//

import UIKit

class NeedToLoginView: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.Login.mainTextFontSize, weight: .bold)
        button.setTitleColor(Constants.Colors.mainText, for: .normal)
        button.backgroundColor = Constants.Colors.secondaryBackground
        button.layer.cornerRadius = 25
        
        button.layer.shadowOpacity = 0.1
        button.layer.shadowRadius = 3.0
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowColor = Constants.Colors.shadow.cgColor
        return button
    }()
    private func setupViews(){
        self.addSubview(loginButton)
        self.backgroundColor = Constants.Colors.mainBackground
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: self.frame.width * 0.7).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

