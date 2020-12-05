//
//  StackViewWithTwoTableViews.swift
//  projectX
//
//  Created by Radomyr Bezghin on 10/17/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

class SegmentedControlWithTableViewAndCollectionView: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Posts", "Missions"])
        sc.selectedSegmentIndex = 0
        sc.selectedSegmentTintColor = .white
        sc.layer.backgroundColor = UIColor.white.cgColor
        sc.tintColor = .white
        sc.addTarget(self, action: #selector(performAnimation), for: .valueChanged)
        return sc
    }()
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        return stack
    }()
    let loungeTableView: UITableView = {
        let home = UITableView()
        home.separatorStyle = .none
        home.backgroundColor = .white
        home.translatesAutoresizingMaskIntoConstraints = false
        return home
    }()
    lazy var bulletinBoardCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.minimumInteritemSpacing = 1
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private func setupViews(){
        self.addSubview(segmentedControl)
        self.addSubview(stackView)
        stackView.addArrangedSubview(loungeTableView)
        stackView.addArrangedSubview(bulletinBoardCollectionView)
        segmentedControl.addAnchors(top: self.layoutMarginsGuide.topAnchor,
                                     leading: self.layoutMarginsGuide.leadingAnchor,
                                     bottom: nil,
                                     trailing: self.layoutMarginsGuide.trailingAnchor,
                                     padding: .init(top: 0, left: 10, bottom: 0, right: 10))
        stackView.addAnchors(top: segmentedControl.bottomAnchor,
                                            leading: self.leadingAnchor,
                                            bottom: self.bottomAnchor,
                                            trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 10),
                                            size: .init(width: (self.frame.width * 2), height: 0))
    }
    /// Animation for switching between two tableViewControllers
    private var toggle: Bool = true
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
