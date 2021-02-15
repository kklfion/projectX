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
        imageView.image = UIImage(named: "iconFinalFinal")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        //label.text = //"Necto"
        label.textColor = Constants.Colors.mainText
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
        field.placeholder = "College Email"
        field.font = UIFont.systemFont(ofSize: Constants.Login.mainTextFontSize)
        let imageView = UIImageView(image: UIImage(systemName: "envelope"))
        field.setLeftIcon(UIImage(systemName: "envelope")!, width: 25, height: 18)
        field.textColor = Constants.Colors.mainText
        field.tintColor = Constants.Colors.mainText
        field.borderStyle = .none
        field.heightAnchor.constraint(equalToConstant: 30).isActive = true
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
        field.setLeftIcon(UIImage(systemName: "lock")!)
        field.isSecureTextEntry = true
        field.textColor = Constants.Colors.mainText
        field.tintColor = Constants.Colors.mainText
        field.borderStyle = .none
        field.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return field
    }()
    let errorButton: UIButton = {
        let button = UIButton()
        button.setTitle("Error", for: .normal)
        button.isEnabled = false
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(Constants.Colors.buttonsRed, for: .normal)
        return button
    }()
    let forgotLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot password?", for: .normal)
        button.setTitleColor(Constants.Colors.mainText, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.Login.otherTextFontSize)
        return button
    }()
    let errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.Login.otherTextFontSize)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        label.textColor = Constants.Colors.buttonsRed
        return label
    }()
    let loginSignUpStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.Login.mainTextFontSize, weight: .bold)
        button.setTitleColor(Constants.Colors.mainText, for: .normal)
        button.backgroundColor = Constants.Colors.secondaryBackground
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 25
        
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 3.0
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowColor = Constants.Colors.shadow.cgColor
        return button
    }()
    let spacingButton: UIButton = {
        let button = UIButton()
        button.setTitle("or", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.Login.mainTextFontSize)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(Constants.Colors.darkBrown, for: .normal)
        
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return button
    }()
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(Constants.Colors.mainText, for: .normal)
        button.backgroundColor = Constants.Colors.secondaryBackground
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.Login.mainTextFontSize, weight: .bold)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 25
        
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 3.0
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowColor = Constants.Colors.shadow.cgColor
        return button
    }()
    let skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("skip", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.Login.mainTextFontSize)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(Constants.Colors.mainText, for: .normal)
        return button
    }()
    
    
    func setupViews(){
        setupBackgroundView()
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
                                 trailing: emailPasswordStackView.trailingAnchor,
                                 padding: .init(top: 10, left: Constants.Login.logoPadding, bottom: -15, right: Constants.Login.logoPadding))
        logoImageView.topAnchor.constraint(greaterThanOrEqualTo:self.topAnchor, constant: 10).isActive = true
        logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor).isActive = true
        nameLabel.addAnchors(top: nil,
                             leading: emailPasswordStackView.leadingAnchor,
                             bottom: emailPasswordStackView.topAnchor,
                             trailing: emailPasswordStackView.trailingAnchor,
                             padding: .init(top: 0, left: 0, bottom: Constants.Login.EmailPasswordStackViewTopPadding, right: 0),
                             size: .init(width: 0, height: 0))
        forgotLoginButton.addAnchors(top: emailPasswordStackView.bottomAnchor,
                                     leading: emailPasswordStackView.leadingAnchor,
                                     bottom: nil,
                                     trailing: emailPasswordStackView.trailingAnchor)
        errorLabel.addAnchors(top: nil,
                              leading:  nil,
                              bottom: emailPasswordStackView.topAnchor,
                              trailing: nil,
                              padding: .init(top: 0, left: 0, bottom: Constants.Login.errorPadding, right: 0))
        errorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loginSignUpStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loginSignUpStackView.addAnchors(top: forgotLoginButton.bottomAnchor,
                                        leading: emailPasswordStackView.leadingAnchor,
                                        bottom: nil,
                                        trailing: emailPasswordStackView.trailingAnchor,
                                        padding: .init(top: Constants.Login.loginSignUpStackViewTopPadding, left: 0, bottom: 0, right: 0))
        skipButton.addAnchors(top: nil,
                              leading: nil,
                              bottom: self.safeAreaLayoutGuide.bottomAnchor,
                              trailing: self.safeAreaLayoutGuide.trailingAnchor,
                              padding: .init(top: 0, left: 0, bottom: 0, right: 30))
    }
    
    func setupBackgroundView() {
        
        
        // Create a CAShapeLayer
        let shapeLayer = CAShapeLayer()
        // The Bezier path thatneeds to be converted to a CGPath before it can be used on a layer.
        shapeLayer.path = createBackgroundBezier().cgPath
        // apply other properties related to the path
        shapeLayer.strokeColor = Constants.Colors.mainYellow.cgColor
        shapeLayer.fillColor = Constants.Colors.mainYellow.cgColor
        shapeLayer.lineWidth = 1.0
        shapeLayer.position = CGPoint(x: 10, y: 10)
        // add the new layer to our custom view
        let path = createBackgroundBezier()
        let scale = CGAffineTransform(scaleX: 5, y: 5)
        path.apply(scale)
        shapeLayer.path = path.cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    func createBackgroundBezier() -> UIBezierPath {
        
        // Use to adjust height of background based of device height
        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
        let yPoint = ((screenHeight/2) / 5) - ((Constants.Login.EmailPasswordStackViewTopPadding - 10) / 2.5)
        
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: -5, y: yPoint))
        
        path.addCurve(to: CGPoint(x: 40, y: yPoint + 5),
                controlPoint1: CGPoint(x: 0, y: yPoint + 5),
                controlPoint2: CGPoint(x: 20, y: yPoint + 20))
        
        path.addCurve(to: CGPoint(x: 90, y: yPoint + 35),
                      controlPoint1: CGPoint(x: 60, y: yPoint - 10),
                      controlPoint2: CGPoint(x: 70, y: yPoint + 20))
        path.addLine(to: CGPoint(x: 90, y: -5))
        path.addLine(to: CGPoint(x: -5, y: -5))
        path.close()
        return path
    }
    
}

