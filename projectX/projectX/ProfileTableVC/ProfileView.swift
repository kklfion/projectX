//
//  ProfileView.swift
//  projectX
//
//  Created by Radomyr Bezghin on 9/23/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    private var toggle: Bool = true

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    let profileImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.layer.borderWidth = 0.5
        imageview.layer.borderColor = UIColor.black.cgColor
        imageview.clipsToBounds = true
        return imageview
    }()
    let bioStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillProportionally
        stack.alignment = .center
        stack.spacing = 10
        stack.axis = .vertical
        return stack
    }()
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .black
        return label
    }()
    let useridLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .lightGray
        return label
    }()
    let schoolLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .black
        return label
    }()
    let spacingView: UIView  = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.alpha = 0.5
        return view
    }()
    //stack that keeps all the views arranged
    let tableViewStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        return stack
    }()
    let segmentController: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Lounge", "Missions"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 0
        sc.selectedSegmentTintColor = .white
        sc.layer.backgroundColor = UIColor.white.cgColor
        sc.tintColor = .white
        sc.addTarget(self, action: #selector(performAnimation), for: .valueChanged)
        return sc
    }()
    let loungeTableView: UITableView = {
        let home = UITableView()
        home.separatorStyle = .none
        home.backgroundColor = .white//UIColor.lightGray.withAlphaComponent(0.3)
        home.translatesAutoresizingMaskIntoConstraints = false
        return home
    }()
    let missionsTableView: UITableView = {
        let rec = UITableView()
        rec.separatorStyle = .none
        rec.backgroundColor = .white//UIColor.lightGray.withAlphaComponent(0.3)
        rec.translatesAutoresizingMaskIntoConstraints = false
        return rec
    }()
    private func setupViews() {
        self.addSubview(profileImageView)
        self.addSubview(bioStackView)
        self.addSubview(segmentController)
        self.addSubview(tableViewStackView)
        self.addSubview(spacingView)
        
        bioStackView.addArrangedSubview(usernameLabel)
        bioStackView.addArrangedSubview(useridLabel)
        bioStackView.addArrangedSubview(schoolLabel)
        
        tableViewStackView.addArrangedSubview(loungeTableView)
        tableViewStackView.addArrangedSubview(missionsTableView)
        
        profileImageView.addAnchors(top: self.safeAreaLayoutGuide.topAnchor,
                                     leading: nil,
                                     bottom: nil,
                                     trailing: nil,
                                     padding: .init(top: 0, left: 0, bottom: 0, right: 0),
                                     size: .init(width: self.frame.width*0.5, height: self.frame.width*0.5))
        profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        profileImageView.layer.cornerRadius = (self.frame.width*0.5 / 2)
        
        bioStackView.addAnchors(top: profileImageView.bottomAnchor,
                                            leading: self.leadingAnchor,
                                            bottom: nil,
                                            trailing: self.trailingAnchor,
                                            padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
        spacingView.addAnchors(top: bioStackView.bottomAnchor,
                                leading: self.leadingAnchor,
                                bottom: nil,
                                trailing: self.trailingAnchor,
                                padding: .init(top: 10, left: 10, bottom: 0, right: 10),
                                size: .init(width: 0, height: 1))
        
        segmentController.addAnchors(top: spacingView.bottomAnchor,
                                     leading: self.layoutMarginsGuide.leadingAnchor,
                                     bottom: nil,
                                     trailing: self.layoutMarginsGuide.trailingAnchor,
                                     padding: .init(top: 10, left: 10, bottom: 0, right: 10))
        tableViewStackView.addAnchors(top: segmentController.bottomAnchor,
                                            leading: self.leadingAnchor,
                                            bottom: self.bottomAnchor,
                                            trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0),
                                            size: .init(width: self.frame.width * 2, height: 0))
    }
    /// Animation for switching between two tableViewControllers
    @objc func performAnimation(){
        let moveToBusStop = {
            self.tableViewStackView.transform = CGAffineTransform(translationX: -self.frame.width, y: 0)
        }
        let reset = {
            self.tableViewStackView.transform = .identity
        }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut,
            animations:{
                self.toggle ? moveToBusStop() : reset()
            }, completion: nil)
        toggle = !toggle
    }

}
