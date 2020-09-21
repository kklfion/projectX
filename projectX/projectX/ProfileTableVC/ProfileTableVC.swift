//
//  ProfileTableVC.swift
//  projectX
//
//  Created by Radomyr Bezghin on 6/15/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileTableVC: UIViewController {
        // MARK: - Properties

       lazy var containerView: UIView = {
            let view = UIView()
        view.backgroundColor = .white
            
            view.addSubview(profileImageView)
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            profileImageView.anchor(top: view.topAnchor, paddingTop: 100,
                                    width: 200, height: 200)
            profileImageView.layer.cornerRadius = 200 / 2
            
            view.addSubview(nameLabel)
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            nameLabel.anchor(top: profileImageView.bottomAnchor, paddingTop: 10)
            
            view.addSubview(uniLabel)
            uniLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            uniLabel.anchor(top: nameLabel.bottomAnchor, paddingTop: 4)
        
            view.addSubview(prePostLabel)
            prePostLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            prePostLabel.anchor(top: uniLabel.bottomAnchor, paddingTop: 60)
            return view
        }()
        

        
        let profileImageView: UIImageView = {
            let iv = UIImageView()
            iv.image = #imageLiteral(resourceName: "profile_icon")
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            iv.layer.borderWidth = 3
            iv.layer.borderColor = UIColor.white.cgColor
            return iv
        }()
        
        let nameLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.text = "Jake Nations"
            label.font = UIFont.boldSystemFont(ofSize: 26)
            label.textColor = .white
            return label
        }()
        
        let uniLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.text = "Universtiy of California, Santa Cruz"
            label.font = UIFont.systemFont(ofSize: 18)
            label.textColor = .black
            return label
        }()
    
        let prePostLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .left
            label.text = "Previous Posts"
            label.font = UIFont.systemFont(ofSize: 26)
            label.textColor = .black
            return label
        }()
    
    let logoutButton: UIButton = {
        let button  = UIButton()
        button.setTitle("Logout", for: .normal)
        button.addTarget(self, action: #selector(logoutCurrentUser), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)

        return button
    }()
        
        // MARK: - Lifecycle
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = .white
            
            view.addSubview(containerView)
            view.addSubview(logoutButton)
            logoutButton.addAnchors(top: view.safeAreaLayoutGuide.topAnchor,
                                    leading: nil,
                                    bottom: nil,
                                    trailing: view.safeAreaLayoutGuide.trailingAnchor,
                                    padding: .init(top: 0, left: 0, bottom: 0, right: Constants.Login.padding) )
            containerView.anchor(top: view.topAnchor, left: view.leftAnchor,
                                 right: view.rightAnchor)
            
            
        }
        
        override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }
        
        // MARK: - Selectors
        
        @objc func handleMessageUser() {
            print("Message user here..")
        }
        
        @objc func handleFollowUser() {
            print("Follow user here..")
        }
    
    @objc func logoutCurrentUser(){
        // TO DO: Send to loginviewcontroller
        if Auth.auth().currentUser != nil {
            do{
                print("signing out")
                try Auth.auth().signOut()
                
            } catch let error{
                print(error)
            }
        }
    }
    
}

    extension UIView {
        
        func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat? = 0,
                    paddingLeft: CGFloat? = 0, paddingBottom: CGFloat? = 0, paddingRight: CGFloat? = 0, width: CGFloat? = nil, height: CGFloat? = nil) {
            
            translatesAutoresizingMaskIntoConstraints = false
            
            if let top = top {
                topAnchor.constraint(equalTo: top, constant: paddingTop!).isActive = true
            }
            
            if let left = left {
                leftAnchor.constraint(equalTo: left, constant: paddingLeft!).isActive = true
            }
            
            if let bottom = bottom {
                if let paddingBottom = paddingBottom {
                    bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
                }
            }
            
            if let right = right {
                if let paddingRight = paddingRight {
                    rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
                }
            }
            
            if let width = width {
                widthAnchor.constraint(equalToConstant: width).isActive = true
            }
            
            if let height = height {
                heightAnchor.constraint(equalToConstant: height).isActive = true
            }
        }
    }
