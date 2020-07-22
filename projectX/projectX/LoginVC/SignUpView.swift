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
        field.borderStyle = .roundedRect
        return field
    }()
    let lastTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Last Name"
        field.font = UIFont.systemFont(ofSize: 15)
        field.textColor = .black
        field.borderStyle = .roundedRect
        return field
    }()
    let emailTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.font = UIFont.systemFont(ofSize: 15)
        field.textColor = .black
        field.borderStyle = .roundedRect
        return field
    }()
    let passwordTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.font = UIFont.systemFont(ofSize: 15)
        field.textColor = .black
        field.borderStyle = .roundedRect
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
    let errorButton: UIButton = {
        let button = UIButton()
        button.setTitle("Error", for: .normal)
        button.isEnabled = false
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    func setupViews(){
        [nameTextField, lastTextField, emailTextField, passwordTextField, spacingButton,signUpButton, errorButton].forEach({stackView.addArrangedSubview($0)})
        [stackView].forEach({self.addSubview($0)})
        
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.addAnchors(top: nil,
                             leading: self.leadingAnchor,
                             bottom: nil,
                             trailing: self.trailingAnchor,
                             padding: .init(top: 0, left: 70, bottom: 0, right: 70),
                             size: .init(width: 0, height: 0))
    }
}
