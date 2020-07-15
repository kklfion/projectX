//
//  ProfileTableVC.swift
//  projectX
//
//  Created by Radomyr Bezghin on 6/15/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

class ProfileTableVC: UIViewController {
        // MARK: - Properties

       lazy var containerView: UIView = {
            let view = UIView()
            view.backgroundColor = .mainBlue
            
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
            label.textColor = .white
            return label
        }()
    
        let prePostLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .left
            label.text = "Previous Posts"
            label.font = UIFont.systemFont(ofSize: 26)
            label.textColor = .white
            return label
        }()
        
        // MARK: - Lifecycle
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = .blue
            
            view.addSubview(containerView)
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
    }

    extension UIColor {
        static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
            return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
        }
        
        static let mainBlue = UIColor.rgb(red: 0, green: 150, blue: 255)
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
