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
    var cellHeight: CGFloat? //0.165 * view.frame.height
    let homeView = HomeView()
    var postData = [PostModel]() //short description of the post

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
        
        setupSearchController()
        
        createFakeData()
        
    }
    func setupSearchController(){
        let somevc = NewPostVC() //as a dummy
        somevc.view.backgroundColor = .lightGray
        let searchController = UISearchController(searchResultsController: somevc)
        searchController.searchResultsUpdater = self // should be somevc
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func createFakeData(){
        var image = UIImage(named: "ucsc")
        postData.append(PostModel(image: image, title: "CSE12", preview: "I didnt cheat but was flagged ...", author: "Sammy", likesCount: 17, commentsCount: 13, postID: "1"))
        image = UIImage(named: "airpods")
        postData.append(PostModel(image: image, title: "Lost my airpods", preview: "Last time I've seen them at Oakes ...", author: "Sammy", likesCount: 12, commentsCount: 5, postID: "2"))
        postData.append(PostModel(image: nil, title: "Protesters attacked Tantalo", preview: "How dare they touch the god himself ...", author: "Sammy", likesCount: 6, commentsCount: 2, postID: "3"))
        postData.append(PostModel(image: nil, title: "I ran out of ideas", preview: "some preview text ...", author: "Sammy", likesCount: 12, commentsCount: 13, postID: "4"))
        postData.append(PostModel(image: nil, title: "I ran out of ideas", preview: "some preview text ...", author: "Sammy", likesCount: 12, commentsCount: 13, postID: "5"))
        postData.append(PostModel(image: nil, title: "I ran out of ideas", preview: "some preview text ...", author: "Sammy", likesCount: 12, commentsCount: 13, postID: "6"))

    }
}

extension HomeTableVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension HomeTableVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        postData.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        cellHeight = 0.165 * view.frame.height
        return cellHeight ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: postCellID, for: indexPath) as? PostCell else {
            fatalError("Wrong cell at cellForRowAt? ")
        }
        if tableView == homeView.homeTableView{
            
        }else if  tableView == homeView.recommendingTableView{
        }
        
        cell.titleUILabel.text =  postData[indexPath.row].title
        cell.previewUILabel.text =  postData[indexPath.row].preview
        cell.authorUILabel.text =  postData[indexPath.row].author
        cell.likesUILabel.text =  String(postData[indexPath.row].likesCount)
        cell.commentsUILabel.text =  String(postData[indexPath.row].commentsCount)
        cell.UID =  postData[indexPath.row].postID
        cell.dateUILabel.text = "\(indexPath.row)h"
        if postData[indexPath.row].image != nil{
            //add an image
            cell.withImageViewConstraints()
            cell.postUIImageView.image = postData[indexPath.row].image
        }else{
            //no image to display
            cell.noImageViewConstraints()
        }
        return cell
    }
}
  
