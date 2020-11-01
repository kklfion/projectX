//
//  LoginView.swift
//  projectX
//
//  Created by Radomyr Bezghin on 7/17/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

class LoginView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        //imageView.image = UIImage(named: "yoda")
        imageView.clipsToBounds = true
        //imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Necto"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: Constants.Login.logoFontSize)
        label.textAlignment = .center
        return label
    }()
    //stack that keeps all the views arranged
    let emailPasswordStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.axis = .vertical
        return stack
    }()
    let emailTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.font = UIFont.systemFont(ofSize: Constants.Login.mainTextFontSize)
        let imageView = UIImageView(image: UIImage(systemName: "envelope"))
        field.leftView = imageView
        field.leftViewMode = .always
        field.leftView?.tintColor = .systemGreen
        //field.backgroundColor = .blue
        field.textColor = .black
        field.borderStyle = .none
        return field
    }()
    let topSpacingButton: UIButton = {
        let button = UIButton()
        return button
    }()
    let passwordTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.font = UIFont.systemFont(ofSize: Constants.Login.mainTextFontSize)
        let imageView = UIImageView(image: UIImage(systemName: "lock"))
        field.leftView = imageView
        field.leftView?.tintColor = .systemGreen
        field.leftViewMode = .always
        field.isSecureTextEntry = true
        //field.backgroundColor = .yellow
        field.textColor = .black
        field.borderStyle = .none
        return field
    }()
    let errorButton: UIButton = {
        let button = UIButton()
        button.setTitle("Error", for: .normal)
        button.isEnabled = false
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    let forgotLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot password ?", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.Login.otherTextFontSize)
        return button
    }()
    let errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.Login.otherTextFontSize)
        //label.text = "error"
        label.textAlignment = .center
        label.numberOfLines = 0
        
        label.textColor = .systemRed
        return label
    }()
    let loginSignUpStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.Login.mainTextFontSize)
        return button
    }()
    let spacingButton: UIButton = {
        let button = UIButton()
        button.setTitle("or", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.Login.otherTextFontSize)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.Login.mainTextFontSize)
        button.addTarget(self, action: #selector(signMeUp), for: .touchUpInside)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.systemGreen.cgColor
        button.layer.cornerRadius = 15
        return button
    }()
    let skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("skip", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.Login.otherTextFontSize)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.lightGray, for: .normal)
        return button
    }()
    

    func setupViews(){
        [emailTextField,topSpacingButton, passwordTextField].forEach({emailPasswordStackView.addArrangedSubview($0)})
        [loginButton,spacingButton, registerButton].forEach({loginSignUpStackView.addArrangedSubview($0)})
        [logoImageView,nameLabel,emailPasswordStackView,forgotLoginButton,errorLabel,loginSignUpStackView, skipButton].forEach({self.addSubview($0)})
        
        emailPasswordStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        emailPasswordStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        emailPasswordStackView.addAnchors(top: nil,
                             leading: self.leadingAnchor,
                             bottom: nil,
                             trailing: self.trailingAnchor,
                             padding: .init(top: 0, left: Constants.Login.stackViewLeftRightPadding, bottom: 0, right: Constants.Login.stackViewLeftRightPadding))
        
        logoImageView.addAnchors(top: nil,
                                 leading: emailPasswordStackView.leadingAnchor,
                                 bottom: nameLabel.topAnchor,
                                 trailing: emailPasswordStackView.trailingAnchor)
        logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor).isActive = true
        nameLabel.addAnchors(top: nil,
                             leading: emailPasswordStackView.leadingAnchor,
                             bottom: emailPasswordStackView.topAnchor,
                             trailing: emailPasswordStackView.trailingAnchor,
                             padding: .init(top: 0, left: 0, bottom: Constants.Login.padding, right: 0),
                             size: .init(width: 0, height: 0))
        forgotLoginButton.addAnchors(top: emailPasswordStackView.bottomAnchor,
                                     leading: emailPasswordStackView.leadingAnchor,
                                     bottom: nil,
                                     trailing: emailPasswordStackView.trailingAnchor)
        errorLabel.addAnchors(top: forgotLoginButton.bottomAnchor,
                              leading:  nil,
                              bottom: nil,
                              trailing: nil)
        errorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loginSignUpStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loginSignUpStackView.addAnchors(top: forgotLoginButton.bottomAnchor,
                             leading: emailPasswordStackView.leadingAnchor,
                             bottom: nil,
                             trailing: emailPasswordStackView.trailingAnchor,
                             padding: .init(top: Constants.Login.bottomStackViewTopPadding, left: 0, bottom: 0, right: 0))
        skipButton.addAnchors(top: nil,
                              leading: nil,
                              bottom: self.safeAreaLayoutGuide.bottomAnchor,
                              trailing: emailPasswordStackView.trailingAnchor)
    }
    
    @objc func signMeUp(){
//        let signUpController = SignUpViewController()
//        let nv = UINavigationController(rootViewController: signUpController)
        //present
    }
}
