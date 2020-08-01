//
//  HomeTableVC.swift
//  projectX
//
//  Created by Radomyr Bezghin on 6/15/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//
//
/*

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
        
        setupTableViewsDelegates()
        setupSearchController()
        createFakeData()
        
    }
    func setupTableViewsDelegates(){
        homeView.homeTableView.delegate = self
        homeView.recommendingTableView.delegate = self
        homeView.homeTableView.dataSource = self
        homeView.recommendingTableView.dataSource = self
        
        homeView.homeTableView.rowHeight = UITableView.automaticDimension
        homeView.recommendingTableView.estimatedRowHeight = view.frame.size.height / 4
        homeView.homeTableView.rowHeight = UITableView.automaticDimension
        homeView.recommendingTableView.estimatedRowHeight = view.frame.size.height / 4
        
        homeView.homeTableView.register(PostCell.self, forCellReuseIdentifier: postCellID)
        homeView.recommendingTableView.register(PostCell.self, forCellReuseIdentifier: postCellID)
    }
    /// setup top seatchBar to seatch for particular posts
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
    /// fill in tableView with fake data
    func createFakeData(){
        var image = UIImage(named: "ucsc")
        postData.append(PostModel(image: image, title: "Will we be having online classes for the whole school year?", preview: "I decided to stay home for the fall quarter bc everything will be online but will... ", author: "Sammy", likesCount: 17, commentsCount: 13, postID: "1"))
        image = UIImage(named: "airpods")
        postData.append(PostModel(image: image, title: "Community college improves graduation rate", preview: "Study: Students Who Take Some Courses At Community Colleges Increase Their Chances Of Earning A Bachelor’s Degree", author: "Sammy", likesCount: 12, commentsCount: 511, postID: "2"))
        postData.append(PostModel(image: nil, title: "Zoom Settings", preview: "", author: "Sammy", likesCount: 6, commentsCount: 2, postID: "3"))
        postData.append(PostModel(image: nil, title: "UCSC 2020-21 Freshman Acceptance Rate is 65.25%", preview: "some preview text I ran out of ideas I ran out of ideas I ran out of ideas I ran out of ideas I ran out of ideas ", author: "Sammy", likesCount: 12, commentsCount: 13, postID: "4"))
        postData.append(PostModel(image: nil, title: "I ran out of ideas", preview: "some preview text", author: "Sammy", likesCount: 12, commentsCount: 13, postID: "5"))
        postData.append(PostModel(image: nil, title: "I ran out of ideas", preview: "some preview text", author: "Sammy", likesCount: 12, commentsCount: 13, postID: "6"))
        postData.append(PostModel(image: nil, title: "I ran out of ideas ", preview: "some preview text I ran out of ideas I ran out of ideas I ran out of ideas I ran out of ideas I ran out of ideas", author: "Sammy", likesCount: 12, commentsCount: 13, postID: "7"))
        postData.append(PostModel(image: nil, title: "I ran out of ideas", preview: "some preview text", author: "Sammy", likesCount: 12, commentsCount: 13, postID: "8"))

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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: postCellID, for: indexPath) as? PostCell else {
            fatalError("Wrong cell at cellForRowAt? ")
        }
        if tableView == homeView.homeTableView{
            
        }else if  tableView == homeView.recommendingTableView{
        }
        addData(toCell: cell, withIndex: indexPath.row)
        return cell
    }
    func addData(toCell cell: PostCell, withIndex index: Int ){
        cell.titleUILabel.text =  postData[index].title
        cell.previewUILabel.text =  postData[index].preview
        cell.authorUILabel.text =  postData[index].author
        cell.likesUILabel.text =  String(postData[index].likesCount)
        cell.commentsUILabel.text =  String(postData[index].commentsCount)
        cell.UID =  postData[index].postID
        cell.dateUILabel.text = "\(index)h"
        if postData[index].image != nil{
            //this cell will have an image
            cell.postUIImageView.image = postData[index].image
            cell.withImageViewConstraints()
        }else{
            //change cell constraints so that text takes the extra space
            cell.postUIImageView.image = nil
            cell.noImageViewConstraints()
        }
    }
}
  
