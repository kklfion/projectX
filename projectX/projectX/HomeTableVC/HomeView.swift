//
//  HomeView.swift
//  projectX
//
//  Created by Radomyr Bezghin on 6/24/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

class HomeView: UIView {
    
    private var toggle: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    //stack that keeps all the views arranged
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        return stack
    }()
    let segmentController: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Lounge", "Bus Stop"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 0
        sc.selectedSegmentTintColor = .white
        sc.layer.backgroundColor = UIColor.white.cgColor
        sc.tintColor = .white
        sc.addTarget(self, action: #selector(performAnimation), for: .valueChanged)
        return sc
    }()
//    let viewForTableViews: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    let loungeTableView: UITableView = {
        let home = UITableView()
        home.separatorStyle = .none
        home.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        home.translatesAutoresizingMaskIntoConstraints = false
        return home
    }()
    let busStopTableView: UITableView = {
        let rec = UITableView()
        rec.separatorStyle = .none
        rec.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        rec.translatesAutoresizingMaskIntoConstraints = false
        return rec
    }()
    private func setupViews() {
        self.addSubview(segmentController)
        self.addSubview(stackView)
        stackView.addArrangedSubview(loungeTableView)
        stackView.addArrangedSubview(busStopTableView)
        segmentController.addAnchors(top: self.layoutMarginsGuide.topAnchor,
                                     leading: self.layoutMarginsGuide.leadingAnchor,
                                     bottom: nil,
                                     trailing: self.layoutMarginsGuide.trailingAnchor,
                                     padding: .init(top: 0, left: 10, bottom: 0, right: 10))
        stackView.addAnchors(top: segmentController.bottomAnchor,
                                            leading: self.leadingAnchor,
                                            bottom: self.bottomAnchor,
                                            trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0),
                                            size: .init(width: self.frame.width * 2, height: 0))
    }
    
    
    /// Animation for switching between two tableViewControllers
    @objc func performAnimation(){
        let moveToBusStop = {
            self.stackView.transform = CGAffineTransform(translationX: -self.frame.width, y: 0)
        }
        let reset = {
            self.stackView.transform = .identity
        }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut,
            animations:{
                self.toggle ? moveToBusStop() : reset()
            }, completion: nil)
        toggle = !toggle
    }
}

