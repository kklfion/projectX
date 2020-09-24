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
    
    var cellHeight: CGFloat? //0165 * view.frame.height
    let homeView = HomeView()
    var postData = [Post]()

    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableViewsDelegates()
        setupSearchController()
    }
    func setupTableViewsDelegates(){
        homeView.homeTableView.delegate = self
        homeView.recommendingTableView.delegate = self
        homeView.homeTableView.dataSource = self
        homeView.recommendingTableView.dataSource = self
        
        homeView.homeTableView.rowHeight = UITableView.automaticDimension
        homeView.homeTableView.estimatedRowHeight = 300
        homeView.recommendingTableView.rowHeight = UITableView.automaticDimension
        homeView.recommendingTableView.estimatedRowHeight = 300
        
        homeView.homeTableView.register(PostCell.self, forCellReuseIdentifier: Constants.PostCellID)
        homeView.recommendingTableView.register(PostCell.self, forCellReuseIdentifier: Constants.PostCellID)
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

}

extension HomeTableVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension HomeTableVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        postData.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postvc = PostViewController()
        postvc.modalPresentationStyle = .fullScreen
        postvc.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(postvc, animated: true)
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.PostCellID, for: indexPath) as? PostCell else {
            fatalError("Wrong cell at cellForRowAt? ")
        }
        if tableView == homeView.homeTableView{
            
        }else if  tableView == homeView.recommendingTableView{
        }
        cell.channelUIButton.addTarget(self, action: #selector(dummyStation), for: .touchUpInside)
        addData(toCell: cell, withIndex: indexPath.row)
        return cell
    }
    @objc func dummyStation(){
        let station = StationsVC()
        station.modalPresentationStyle = .fullScreen
        //station.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(station, animated: true)
    }
    func addData(toCell cell: PostCell, withIndex index: Int ){
        cell.titleUILabel.text =  postData[index].title
        cell.previewUILabel.text =  postData[index].text
        cell.authorUILabel.text =  postData[index].userInfo.name
        cell.likesUILabel.text =  String(postData[index].likes!)
        cell.commentsUILabel.text =  String(postData[index].commentCount!)
        //cell.UID =  postData[index].postID
        cell.dateUILabel.text = "\(index)h"
        if postData[index].imageURL != nil{
            //this cell will have an image
            //Converting URL to UiImage object
            let imageTest = UIImageView()
            imageTest.load(url: postData[index].imageURL!)
            cell.postUIImageView.image = imageTest.image
            cell.withImageViewConstraints()
        }else{
            //change cell constraints so that text takes the extra space
            cell.postUIImageView.image = nil
            cell.noImageViewConstraints()
        }
    }
}


