//
//  HomeView.swift
//  projectX
//
//  Created by Radomyr Bezghin on 6/24/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

class HomeView: UIView {
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
        stack.axis = .vertical
        return stack
    }()
    let segmentController: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Home", "Recommending"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(performAnimation), for: .valueChanged)
        return sc
    }()
    let viewForTableViews: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let homeTableView: UITableView = {
        let home = UITableView()
        home.separatorStyle = .none
        home.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        home.translatesAutoresizingMaskIntoConstraints = false
        return home
    }()
    let recommendingTableView: UITableView = {
        let rec = UITableView()
        rec.separatorStyle = .none
        rec.backgroundColor = .lightGray
        rec.translatesAutoresizingMaskIntoConstraints = false
        return rec
    }()
    
    //MARK: Setup views, add them to the stack view and then add constraints
    var leftHomeAnchor: NSLayoutConstraint?
    var leftRecAnchor: NSLayoutConstraint?
    var rightHomeAnchor: NSLayoutConstraint?
    var rightRecAnchor: NSLayoutConstraint?
    
    func setupViews() {
        viewForTableViews.addSubview(homeTableView)
        viewForTableViews.addSubview(recommendingTableView)
        
        homeTableView.topAnchor.constraint(equalTo: viewForTableViews.safeAreaLayoutGuide.topAnchor).isActive = true
        homeTableView.bottomAnchor.constraint(equalTo: viewForTableViews.safeAreaLayoutGuide.bottomAnchor).isActive = true
        leftHomeAnchor = homeTableView.leadingAnchor.constraint(equalTo: viewForTableViews.safeAreaLayoutGuide.leadingAnchor)
        leftRecAnchor?.isActive = true
        rightHomeAnchor = homeTableView.trailingAnchor.constraint(equalTo: viewForTableViews.safeAreaLayoutGuide.leadingAnchor)
        rightHomeAnchor?.isActive = false
        homeTableView.widthAnchor.constraint(equalTo: viewForTableViews.widthAnchor).isActive = true
        
        recommendingTableView.topAnchor.constraint(equalTo: viewForTableViews.safeAreaLayoutGuide.topAnchor).isActive = true
        recommendingTableView.bottomAnchor.constraint(equalTo: viewForTableViews.safeAreaLayoutGuide.bottomAnchor).isActive = true
        leftRecAnchor = recommendingTableView.leadingAnchor.constraint(equalTo: viewForTableViews.safeAreaLayoutGuide.trailingAnchor)
        leftRecAnchor?.isActive = true
        rightRecAnchor = recommendingTableView.trailingAnchor.constraint(equalTo: viewForTableViews.safeAreaLayoutGuide.trailingAnchor)
        rightRecAnchor?.isActive = false
        recommendingTableView.widthAnchor.constraint(equalTo: viewForTableViews.widthAnchor).isActive = true
        stackView.addArrangedSubview(segmentController)
        stackView.addArrangedSubview(viewForTableViews)
        
        self.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        segmentController.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    
    /// Animation for switching between two tableViewControllers
    @objc func performAnimation(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut,
            animations:
            {
                if(self.segmentController.selectedSegmentIndex == 0){
                    //move home to the right
                    self.leftHomeAnchor?.isActive = true
                    self.rightHomeAnchor?.isActive = false
                    //move recommendation to the right
                    self.leftRecAnchor?.isActive = true
                    self.rightRecAnchor?.isActive = false
                    self.viewForTableViews.layoutIfNeeded()
                } else if (self.segmentController.selectedSegmentIndex == 1){
                    //move home to the left
                    self.leftHomeAnchor?.isActive = false
                    self.rightHomeAnchor?.isActive = true
                    //move recommendation to the left
                    self.leftRecAnchor?.isActive = false
                    self.rightRecAnchor?.isActive = true
                    self.viewForTableViews.layoutIfNeeded()
                }
        }, completion: nil)
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
