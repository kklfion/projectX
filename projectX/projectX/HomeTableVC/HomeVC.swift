//
//  HomeTableVC.swift
//  projectX
//
//  Created by Radomyr Bezghin on 6/15/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//
//
import UIKit
class HomeTableVC: UIViewController{
    private var homeView: HomeView?
    private var postData = FakePostData().giveMeSomeData()
    private let seachView: UISearchBar = {
        let sb = UISearchBar()
        sb.showsCancelButton = true
        return sb
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableViewsDelegates()
        setupSearchController()
    }
    private func setupView(){
        self.view.backgroundColor = .white
        homeView = HomeView(frame: self.view.frame)
        homeView?.backgroundColor = .white
        view.addSubview(homeView!)
        homeView?.addAnchors(top: self.view.topAnchor,
                             leading: self.view.leadingAnchor,
                             bottom: self.view.bottomAnchor,
                             trailing: self.view.trailingAnchor)
    }
    private func setupTableViewsDelegates(){
        homeView?.loungeTableView.delegate = self
        homeView?.busStopTableView.delegate = self
        homeView?.loungeTableView.dataSource = self
        homeView?.busStopTableView.dataSource = self
        
        homeView?.loungeTableView.rowHeight = UITableView.automaticDimension
        homeView?.loungeTableView.estimatedRowHeight = 100
        homeView?.busStopTableView.rowHeight = UITableView.automaticDimension
        homeView?.busStopTableView.estimatedRowHeight = 100
        
        homeView?.loungeTableView.register(PostCell.self, forCellReuseIdentifier: Constants.PostCellID)
        homeView?.busStopTableView.register(PostCell.self, forCellReuseIdentifier: Constants.PostCellID)
    }
    /// setup top seatchBar to seatch for particular posts
    private func setupSearchController(){
        navigationItem.titleView = seachView
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
        //TODO: setup loading data
        let postvc = PostViewController()
        postvc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(postvc, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.PostCellID, for: indexPath) as? PostCell else {
            fatalError("Wrong cell at ?cellForRowAt? ")
        }
        if tableView == homeView?.loungeTableView{
            
        }else if  tableView == homeView?.busStopTableView{
        }
        cell.channelUIButton.addTarget(self, action: #selector(dummyStation), for: .touchUpInside)
        addData(toCell: cell, withIndex: indexPath.row)
        return cell
    }
    @objc private func dummyStation(){
        //TODO: finish use data to load it
        let station = StationsVC()
        station.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(station, animated: true)
    }
    private func addData(toCell cell: PostCell, withIndex index: Int ){
        cell.titleUILabel.text =  postData[index].title
        cell.previewUILabel.text =  postData[index].preview
        cell.authorUILabel.text =  postData[index].author
        cell.likesUILabel.text =  String(postData[index].likesCount)
        cell.commentsUILabel.text =  String(postData[index].commentsCount)
        //cell.UID =  postData[index].postID
        cell.dateUILabel.text = "\(index)h"
        if postData[index].image != nil{
            cell.imageView?.isHidden = false
            //this cell will have an image
            cell.postUIImageView.image = postData[index].image
            cell.withImageViewConstraints()
        }else{
            //change cell constraints so that text takes the extra space
            cell.imageView?.isHidden = true
            cell.postUIImageView.image = nil
            cell.noImageViewConstraints()
        }
    }
}
  
