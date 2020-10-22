//
//  HomeTableVC.swift
//  projectX
//
//  Created by Radomyr Bezghin on 6/15/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//
//
import UIKit
import FirebaseAuth

class HomeTableVC: UIViewController{
    
    private var homeView: HomeView?
    var refreshControl: UIRefreshControl?
    private var postData = [Post]()
    
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
        addRefreshControl()
        signInUserIfNeeded()
    }
    private func signInUserIfNeeded(){
        if Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let navvc = UINavigationController(rootViewController: vc)
            navvc.modalPresentationStyle = .fullScreen
            self.tabBarController?.present(navvc, animated: true)
        }else{
            UserManager.shared.loadCurrentUser(withId: Auth.auth().currentUser?.uid ?? "")
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        queryData.queryPost{ [weak self] (posts) in
            self?.postData.append(contentsOf: posts)
            DispatchQueue.main.async {
                self?.homeView?.loungeTableView.reloadData()
            }

        }
    }
    func addRefreshControl(){
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = UIColor.white
        refreshControl?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        homeView?.loungeTableView.addSubview(refreshControl!)
        
    }
    @objc func refreshList(){
        //update data in refreshlist ... somehow, when new data appears
        refreshControl?.endRefreshing()
        homeView?.loungeTableView.reloadData()
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
        
        homeView?.loungeTableView.register(PostCellWithImage.self, forCellReuseIdentifier: PostCellWithImage.cellID)
        homeView?.loungeTableView.register(PostCellWithoutImage.self, forCellReuseIdentifier: PostCellWithoutImage.cellID)
        homeView?.busStopTableView.register(PostCellWithImage.self, forCellReuseIdentifier: PostCellWithImage.cellID)
        homeView?.busStopTableView.register(PostCellWithoutImage.self, forCellReuseIdentifier: PostCellWithoutImage.cellID)
    }
    /// setup top seatchBar to seatch for particular posts
    private func setupSearchController(){
        navigationItem.titleView = seachView
    }
}
extension HomeTableVC: SideBarStationSelectionDelegate{
    func didTapSidebarStation(withId stationId: String) {
        //need to check what kind of station is that
        if (false){
            let vc = SubStationsVC()
            vc.stationId = "ewH1QLwp393Za7g0AQfv"
            navigationController?.pushViewController(vc, animated: true)
        }else if(true){
            let vc = StationsViewController()
            vc.stationId = "ewH1QLwp393Za7g0AQfv"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
extension HomeTableVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
extension HomeTableVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        guard let cell = cell as? PostCell else {return}
//        let radius = cell.shadowLayerView.layer.cornerRadius
//        cell.shadowLayerView.layer.shadowPath = UIBezierPath(roundedRect: cell.shadowLayerView.bounds, cornerRadius: radius).cgPath
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        postData.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentPostFor(indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch postData[indexPath.row].imageURL {
        case nil:
            if let cell = tableView.dequeueReusableCell(withIdentifier: PostCellWithoutImage.cellID, for: indexPath) as? PostCellWithoutImage{
                addData(toCell: cell, withIndex: indexPath.row)
                cell.selectionStyle = .none
                cell.indexPath = indexPath
                cell.delegate = self
                return cell
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: PostCellWithImage.cellID, for: indexPath) as? PostCellWithImage{
                addData(toCell: cell, withIndex: indexPath.row)
                cell.indexPath = indexPath
                cell.delegate = self
                cell.selectionStyle = .none
                return cell
            }
        }
        return UITableViewCell()
    }
    private func addData(toCell cell: UITableViewCell, withIndex index: Int ){
        if let cell = cell as? PostCellWithImage{
            cell.titleUILabel.text =  postData[index].title
            cell.previewUILabel.text =  postData[index].text
            cell.authorUILabel.text =  postData[index].userInfo.name
            cell.likesLabel.text =  String(postData[index].likes)
            cell.commentsUILabel.text =  String(postData[index].commentCount)
            cell.dateUILabel.text = "\(index)h"
            cell.stationButton.setTitle(postData[index].stationName, for: .normal)
            
            let temp = UIImageView()
            temp.load(url: postData[index].imageURL!)
            cell.postUIImageView.image = temp.image
        }else if let cell = cell as? PostCellWithoutImage {
            cell.titleUILabel.text =  postData[index].title
            cell.previewUILabel.text =  postData[index].text
            cell.authorUILabel.text =  postData[index].userInfo.name
            cell.likesLabel.text =  String(postData[index].likes)
            cell.commentsUILabel.text =  String(postData[index].commentCount)
            cell.stationButton.setTitle(postData[index].stationName, for: .normal)
            cell.dateUILabel.text = "\(index)h"
        }
    }
    private func presentPostFor(indexPath: IndexPath){
        let postvc = PostViewController()
        postvc.post = postData[indexPath.row]
        postvc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(postvc, animated: true)
    }
    private func presentStationFor(indexPath: IndexPath){
        let station = SubStationsVC()
        station.stationId = postData[indexPath.row].stationID
        station.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(station, animated: true)
    }
}
extension HomeTableVC: PostCellDidTapDelegate{
    func didTapStationButton(_ indexPath: IndexPath) {
        presentStationFor(indexPath: indexPath)
    }
    func didTapLikeButton(_ indexPath: IndexPath) {
        
    }
    func didTapDislikeButton(_ indexPath: IndexPath) {
        
    }
    func didTapCommentsButton(_ indexPath: IndexPath) {
        presentPostFor(indexPath: indexPath)
    }
}
