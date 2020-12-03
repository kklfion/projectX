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

class HomeTableVC: UIViewController, RoundedCornerNavigationBar{

    private var homeView: HomeView?
    var refreshControl: UIRefreshControl?
    private var postData = [Post]()
    private let queryPosts = queryData()

    private let seachView: UISearchBar = {
        let sb = UISearchBar()
        sb.searchTextField.backgroundColor = .white
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
    override func viewWillAppear(_ animated: Bool) {
        self.addRoundedCorner(OnNavigationBar: navigationController!.navigationBar, cornerRadius: 20)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        queryPosts.queryPost(pagination: false, completion: {[weak self] result in
            switch result {
            case .success(let data):
                self?.postData.append(contentsOf: data)
                DispatchQueue.main.async {
                    self?.homeView?.loungeTableView.reloadData()
                }
            case .failure(_):
                break
            }
        })
    }
    private func signInUserIfNeeded(){
        if Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let navvc = UINavigationController(rootViewController: vc)
            navvc.modalPresentationStyle = .fullScreen
            self.tabBarController?.present(navvc, animated: true)
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
                             trailing: self.view.trailingAnchor,
                             padding: .init(top: 30, left: 0, bottom: 0, right: 0))
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
    func didTapSidebar(station: Station) {
        switch station.stationType {
        case .parentStation:
            let vc = ParentStationViewController()
            vc.station = station
            navigationController?.pushViewController(vc, animated: true)
        default:
            let vc = StationViewController()
            vc.station = station
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

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (homeView!.loungeTableView.contentSize.height-100-scrollView.frame.size.height){
            guard !queryPosts.isPaginating else{
                //we fetching data chill the fuck out
                return
            }
            queryPosts.queryPost(pagination: true) { result in
                switch result {
                    case .success(let moreData):
                        self.postData.append(contentsOf: moreData)
                    DispatchQueue.main.async {
                        self.homeView?.loungeTableView.reloadData()
                    }
                    case .failure(_):
                        break
                }

            }
            //print("Fetch more data")
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCellWithoutImage.cellID, for: indexPath) as? PostCellWithoutImage else {
            fatalError("Dequeued wrong cell in Home")
        }
        addData(toCell: cell, withIndex: indexPath.row)
        cell.selectionStyle = .none
        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }
    private func addData(toCell cell: PostCellWithoutImage, withIndex index: Int ){
        cell.postImageView.image = nil
        cell.titleLabel.text =  postData[index].title
        cell.messageLabel.text =  postData[index].text
        cell.authorLabel.text =  postData[index].userInfo.name
        cell.likesLabel.text =  String(postData[index].likes)
        cell.commentsLabel.text =  String(postData[index].commentCount)
        cell.stationButton.setTitle(postData[index].stationName, for: .normal)
        
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        let dateString = formatter.string(from: postData[index].date)
        
        cell.dateLabel.text = "\(dateString)"
        if postData[index].imageURL != nil {
            cell.postImageView.isHidden = false
            NetworkManager.shared.getAsynchImage(withURL: postData[index].imageURL) { (image, error) in
                DispatchQueue.main.async {
                    cell.postImageView.image = image
                }
            }
        } else{
            cell.postImageView.isHidden = true
        }
    }
}
extension HomeTableVC: PostCellDidTapDelegate{
    func didTapAuthorLabel(_ indexPath: IndexPath) {
        presentAuthorFor(indexPath: indexPath)
    }

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
    
    private func presentPostFor(indexPath: IndexPath){
        let postvc = PostViewController(post: postData[indexPath.row])
        postvc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(postvc, animated: true)
    }
    private func presentStationFor(indexPath: IndexPath){
        NetworkManager.shared.getDocumentForID(collection: .stations, uid: postData[indexPath.row].stationID) { (document: Station?, error) in
            if error != nil {
                print("error receiving station")
            }else if document != nil {
                let vc = StationViewController()
                vc.station = document
                vc.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    private func presentAuthorFor(indexPath: IndexPath){
        let vc = OtherProfileViewController()
        vc.user = postData[indexPath.row].userInfo
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
