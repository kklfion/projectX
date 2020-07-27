//
//  SignUpView.swift
//  projectX
//
//  Created by Radomyr Bezghin on 7/19/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

class SignUpView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    let nameTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "First Name"
        field.font = UIFont.systemFont(ofSize: 15)
        field.textColor = .black
        return field
    }()
    let lastTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Last Name"
        field.font = UIFont.systemFont(ofSize: 15)
        field.textColor = .black
        return field
    }()
    let emailTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.font = UIFont.systemFont(ofSize: 15)
        field.textColor = .black
        return field
    }()
    let passwordTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.font = UIFont.systemFont(ofSize: 15)
        field.textColor = .black
        field.isSecureTextEntry = true
        return field
    }()
    let spacingButton: UIButton = {
        let button = UIButton()
        return button
    }()
    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    let errorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .systemRed
        label.font = UIFont.systemFont(ofSize: Constants.Login.otherTextFontSize)
        label.numberOfLines = 0
        return label
    }()
    
    func setupViews(){
        [nameTextField, lastTextField, emailTextField, passwordTextField, spacingButton,signUpButton].forEach({stackView.addArrangedSubview($0)})
        [stackView, errorLabel].forEach({self.addSubview($0)})
        
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.addAnchors(top: nil,
                             leading: self.leadingAnchor,
                             bottom: nil,
                             trailing: self.trailingAnchor,
                             padding: .init(top: 0, left: 70, bottom: 0, right: 70),
                             size: .init(width: 0, height: 0))
        errorLabel.addAnchors(top: stackView.bottomAnchor,
                              leading: stackView.leadingAnchor,
                              bottom: nil,
                              trailing: stackView.trailingAnchor,
                              padding: .init(top: Constants.Login.padding, left: 0, bottom: 0, right: 0))
    }
}
