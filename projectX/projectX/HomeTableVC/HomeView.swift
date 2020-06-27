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
    //THIS must be a UISearchBar
    //https://www.raywenderlich.com/4363809-uisearchcontroller-tutorial-getting-started
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.backgroundColor = .white
        searchBar.showsCancelButton = true
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
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
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let homeTableView: UITableView = {
        let home = UITableView()
        home.backgroundColor = .blue
        home.translatesAutoresizingMaskIntoConstraints = false
        return home
    }()
    let recommendingTableView: UITableView = {
        let rec = UITableView()
        rec.backgroundColor = .green
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
    
        //stackView.addArrangedSubview(searchBar)
        stackView.addArrangedSubview(segmentController)
        stackView.addArrangedSubview(viewForTableViews)
        
        self.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        searchBar.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        segmentController.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
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
