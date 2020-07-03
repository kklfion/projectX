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

class HomeTableVC: UIViewController{
    
    let postCellID = "postCell"
    
    let homeView = HomeView()

    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        homeView.homeTableView.delegate = self
        homeView.recommendingTableView.delegate = self
        homeView.homeTableView.dataSource = self
        homeView.recommendingTableView.dataSource = self
        homeView.homeTableView.register(PostCell.self, forCellReuseIdentifier: postCellID)
        homeView.recommendingTableView.register(PostCell.self, forCellReuseIdentifier: postCellID)
        
        homeView.homeTableView.rowHeight = UITableView.automaticDimension
        homeView.homeTableView.estimatedRowHeight = 400
        homeView.recommendingTableView.rowHeight = UITableView.automaticDimension
        homeView.recommendingTableView.estimatedRowHeight = 600
        
        setupSearchController()
        
    }
    func setupSearchController(){
        let somevc = NewPostVC() //as a dummy
        somevc.view.backgroundColor = .lightGray
        
        let searchController = UISearchController(searchResultsController: somevc)
        searchController.searchResultsUpdater = self // should be somevc
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        navigationItem.title = "ehhh"
        definesPresentationContext = true
        
    }
}

extension HomeTableVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension HomeTableVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: postCellID, for: indexPath) as! PostCell
        if tableView == homeView.homeTableView{
            //cell.backgroundColor = .lightGray
        }else if  tableView == homeView.recommendingTableView{
            //cell.backgroundColor = .white
        }
        return cell
    }
}
 
