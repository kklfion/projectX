//
//  HomeTableVC.swift
//  projectX
//
//  Created by Radomyr Bezghin on 6/15/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//
//
/*
 1.  Search bar at the top
 2. double tableview controller
 3. bar at the bottom
 
 stackview - searchview,segmented controller, tableView for two tableViewControllers
 
 tableViews dissapear when one or the other is seleted, they go off screen but dont dissapear
 
 
 

 
 */

import UIKit

class HomeTableVC: UIViewController, UITextFieldDelegate{
    //stack that keeps all the views arranged
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    //THIS must be a UISearchBar
    //https://www.raywenderlich.com/4363809-uisearchcontroller-tutorial-getting-started
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search"
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self //to remove the keyboard
        view.backgroundColor = .white
        setupViews()
    }
    
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
        
        
        stackView.addArrangedSubview(searchTextField)
        stackView.addArrangedSubview(segmentController)
        stackView.addArrangedSubview(viewForTableViews)
        
        view.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        searchTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        segmentController.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        
        
        
    }
    @objc func handleSegmentController(){
        switch segmentController.selectedSegmentIndex {
        case 0:
            print("Home selected")
        case 1:
            print("Rec selected")
        default:
            print("Can't really happen")
        }
        
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
    
    //to remove the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchTextField{
            searchTextField.resignFirstResponder()
        }
        return true
    }
    


}



//extension HomeTableVC: UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return UITableViewCell()
//    }
//}
 
