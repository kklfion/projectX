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
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "iconFinal")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Necto"
        label.textColor = Constants.Colors.darkBrown
        label.font = UIFont.boldSystemFont(ofSize: Constants.Login.logoFontSize)
        label.textAlignment = .center
        return label
    }()
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        stack.axis = .vertical
        stack.spacing = 30
        return stack
    }()
    let nameTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Name"
        field.font = UIFont.systemFont(ofSize: Constants.Login.mainTextFontSize)
        //let imageView = UIImageView(image: UIImage(systemName: "mail"))
        field.setLeftIcon(UIImage(systemName: "mail")!, width: 25, height: 18)
        field.textColor = Constants.Colors.darkBrown
        field.tintColor = Constants.Colors.darkBrown
        field.borderStyle = .none
        field.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return field
    }()
    let emailTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.font = UIFont.systemFont(ofSize: Constants.Login.mainTextFontSize)
        //let imageView = UIImageView(image: UIImage(systemName: "envelope"))
        field.setLeftIcon(UIImage(systemName: "envelope")!, width: 25, height: 18)
        field.textColor = Constants.Colors.darkBrown
        field.tintColor = Constants.Colors.darkBrown
        field.borderStyle = .none
        field.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return field
    }()
    let passwordTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.font = UIFont.systemFont(ofSize: Constants.Login.mainTextFontSize)
        //let imageView = UIImageView(image: UIImage(systemName: "lock"))
        field.setLeftIcon(UIImage(systemName: "lock")!)
        field.isSecureTextEntry = true
        field.textColor = Constants.Colors.darkBrown
        field.tintColor = Constants.Colors.darkBrown
        field.borderStyle = .none
        field.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return field
    }()
    let spacingButton: UIButton = {
        let button = UIButton()
        button.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return button
    }()
    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Me Up!", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.Login.mainTextFontSize, weight: .bold)
        button.setTitleColor(Constants.Colors.darkBrown, for: .normal)
        button.backgroundColor = Constants.Colors.mainYellow
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 25
        
        button.layer.shadowOpacity = 0.1
        button.layer.shadowRadius = 3.0
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowColor = UIColor.black.cgColor
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
        setupBackgroundView()
        [nameTextField, emailTextField, passwordTextField, spacingButton,signUpButton].forEach({stackView.addArrangedSubview($0)})
        [stackView, errorLabel].forEach({self.addSubview($0)})
        /*
        logoImageView.addAnchors(top: nil,
                                 leading: stackView.leadingAnchor,
                                 bottom: nameLabel.topAnchor,
                                 trailing: stackView.trailingAnchor,
                                 padding: .init(top: 10, left: Constants.Login.logoPadding, bottom: -15, right: Constants.Login.logoPadding))
        logoImageView.topAnchor.constraint(greaterThanOrEqualTo:self.topAnchor, constant: 10).isActive = true
        logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor).isActive = true
        nameLabel.addAnchors(top: nil,
                             leading: stackView.leadingAnchor,
                             bottom: stackView.topAnchor,
                             trailing: stackView.trailingAnchor,
                             padding: .init(top: 0, left: 0, bottom: Constants.Login.EmailPasswordStackViewTopPadding, right: 0),
                             size: .init(width: 0, height: 0))
        */
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -50).isActive = true
        stackView.addAnchors(top: nil,
                             leading: self.leadingAnchor,
                             bottom: nil,
                             trailing: self.trailingAnchor,
                             padding: .init(top: 0, left: 70, bottom: 0, right: 70),
                             size: .init(width: 0, height: 0))
        errorLabel.addAnchors(top: nil,
                              leading: stackView.leadingAnchor,
                              bottom: stackView.topAnchor,
                              trailing: stackView.trailingAnchor,
                              padding: .init(top: 0, left: 0, bottom: Constants.Login.padding, right: 0))
    }
    
    func setupBackgroundView() {
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        print(screenSize, screenWidth, screenHeight)
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
        
        path.move(to: CGPoint(x: -3, y: yPoint))
        
        path.addCurve(to: CGPoint(x: 40, y: yPoint + 5),
                controlPoint1: CGPoint(x: 0, y: yPoint + 5),
                controlPoint2: CGPoint(x: 20, y: yPoint + 20))
        
        path.addCurve(to: CGPoint(x: 90, y: yPoint + 35),
                      controlPoint1: CGPoint(x: 60, y: yPoint - 10),
                      controlPoint2: CGPoint(x: 70, y: yPoint + 20))
        path.addLine(to: CGPoint(x: 90, y: -25))
        path.addLine(to: CGPoint(x: -3, y: -25))
        path.close()
        return path
    }
}

