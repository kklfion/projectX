//
//  WelcomeScreenVC.swift
//  projectX
//
//  Created by Adedeji Toki on 2/19/21.
//  Copyright © 2021 Radomyr Bezghin. All rights reserved.
//

import UIKit

class WelcomeScreenVC: UIViewController {

    let dimmingView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        UserManager.shared().setToExistingUser()
        self.view.backgroundColor = .clear
        
        dimmingView.backgroundColor = .black
        dimmingView.alpha = 0.0
        self.view.addSubview(dimmingView)
        
        dimmingView.addAnchors(top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor)
        
        let mainView = UIView()
        mainView.layer.cornerRadius = 15
        mainView.layer.masksToBounds = true
        mainView.clipsToBounds = true
        mainView.backgroundColor = Constants.Colors.secondaryBackground
        self.view.addSubview(mainView)
        
        mainView.heightAnchor.constraint(equalToConstant: 496).isActive = true
        mainView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        mainView.addAnchors(top: nil, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor, padding: .init(top: 0, left: 30, bottom: 0, right: 30))
        
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "welcomeImage")
        imageView.contentMode = .scaleAspectFit
        mainView.addSubview(imageView)
        //imageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        imageView.addAnchors(top: mainView.topAnchor, leading: mainView.leadingAnchor, bottom: mainView.centerYAnchor, trailing: mainView.trailingAnchor, padding: .init(top: 30, left: 10, bottom: 0, right: 10))
        
        let welcomeHeaderLabel = UILabel()
        welcomeHeaderLabel.font = UIFont.systemFont(ofSize: 23, weight: .medium)
        welcomeHeaderLabel.textColor = Constants.Colors.mainText
        welcomeHeaderLabel.text = "Hello,"
        mainView.addSubview(welcomeHeaderLabel)
        welcomeHeaderLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor, constant: 0).isActive = true
        //welcomeLabel.centerYAnchor.constraint(equalTo: mainView.centerYAnchor, constant: 50).isActive = true
        welcomeHeaderLabel.addAnchors(top: mainView.centerYAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 30, left: 0, bottom: 0, right: 0))
        
        let welcomeSubtextLabel = UILabel()
        welcomeSubtextLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        welcomeSubtextLabel.textColor = Constants.Colors.mainText
        welcomeSubtextLabel.text = "Welcome to university town!"
        mainView.addSubview(welcomeSubtextLabel)
        welcomeSubtextLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor, constant: 0).isActive = true
        //welcomeLabel.centerYAnchor.constraint(equalTo: mainView.centerYAnchor, constant: 50).isActive = true
        welcomeSubtextLabel.addAnchors(top: welcomeHeaderLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
        let doneButton = UIButton()
        doneButton.setTitle("Done", for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
        doneButton.setTitleColor(Constants.Colors.mainBackground, for: .normal)
        doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        doneButton.backgroundColor = Constants.Colors.darkBrown
        doneButton.layer.cornerRadius = 25
        mainView.addSubview(doneButton)
        doneButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        doneButton.centerXAnchor.constraint(equalTo: mainView.centerXAnchor, constant: 0).isActive = true
        doneButton.addAnchors(top: welcomeSubtextLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 30, left: 0, bottom: 0, right: 0))
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut,
            animations:{
                self.dimmingView.alpha = 0.4
            }, completion: nil)
    }
    @objc func doneButtonAction(){
        self.dismiss(animated: true, completion: nil)
    }

}
