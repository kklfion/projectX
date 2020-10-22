//
//  StationsViewController.swift
//  projectX
//
//  Created by Radomyr Bezghin on 10/21/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

class StationsViewController: UIViewController, UIScrollViewDelegate {
    /// when stationVC is created stationId must be init
    
    let listTableViewCellID = "listTableViewCellID"
    
    var stationId: String?{
        didSet{
            guard let  id = stationId else {return}
            NetworkManager.shared.getDocumentFor(uid: id) { (document: Station?, error) in
                if error != nil {
                    print("error receiving station")
                }else if document != nil {
                    self.station = document
                }
            }
        }
    }
    /// after stationId was init, it loads data and initializes station
    private var station: Station?{
        didSet{
            //setsup ui elems
            setupStationHeaderWithStation()
            //load data for the station
            guard let  id = station?.id else {return}
            NetworkManager.shared.getPostsForStation(id) { (posts, error) in
                if error != nil{
                    print("Error loading posts for station \(String(describing: error?.localizedDescription))")
                }else if posts != nil{
                    self.posts = posts
                }
            }
        }
    }
    private var posts: [Post]?{
        didSet{
            stationView.tableViewAndTableView?.loungeTableView.reloadData()
        }
    }
    private var subStations: [Station]?{
        didSet{
            stationView.tableViewAndTableView?.listTableView.reloadData()
        }
    }
    
    var headerMaxHeight: CGFloat!
    var statusBarHeight: CGFloat!

    lazy var stationView: StationsView = {
        let view = StationsView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: self.view.frame.width,
                                              height: self.view.frame.height),
                                type: .station)
        return view
    }()
    let seachView: UISearchBar = {
        let sb = UISearchBar()
        sb.showsCancelButton = true
        return sb
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setupView()
        setupHeights()
        setupTableView()
        setupBulletinBoardTableView()
    }
    private func setupBulletinBoardTableView(){
        
    }
    private func setupTableView(){
        guard let tableView = stationView.tableViewAndTableView?.loungeTableView else {return}
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(PostCellWithImage.self, forCellReuseIdentifier: PostCellWithImage.cellID)
        tableView.register(PostCellWithoutImage.self, forCellReuseIdentifier: PostCellWithoutImage.cellID)
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(handleTableViewRefresh(_:)), for: UIControl.Event.valueChanged)
        
        guard let tableViewList = stationView.tableViewAndTableView?.listTableView else {return}
        tableViewList.delegate = self
        tableViewList.dataSource = self
        tableViewList.register(UITableViewCell.self, forCellReuseIdentifier: listTableViewCellID)
        tableViewList.refreshControl = UIRefreshControl()
        tableViewList.refreshControl?.addTarget(self, action: #selector(handleTableViewRefresh(_:)), for: UIControl.Event.valueChanged)
        
    }
    private func setupStationHeaderWithStation(){
        let followers = station?.followers ?? 0
        stationView.followersLabel.text = "\(followers) followers."
        NetworkManager.shared.getAsynchImage(withURL: station?.backgroundImageURL) { (image, error) in
            if image != nil {
                DispatchQueue.main.async {
                    self.stationView.backgroundImageView.image = image
                }
            }
        }
        NetworkManager.shared.getAsynchImage(withURL: station?.frontImageURL) { (image, error) in
            if image != nil {
                DispatchQueue.main.async {
                    self.stationView.frontImageView.image = image
                }
            }
        }
        stationView.stationInfoLabel.text = station?.info
        stationView.stationNameLabel.text = station?.stationName
        
    }
    private func setupView(){
        navigationItem.titleView = seachView
        view.addSubview(stationView)
        stationView.addAnchors(top: view.safeAreaLayoutGuide.topAnchor,
                           leading: view.safeAreaLayoutGuide.leadingAnchor,
                           bottom: view.bottomAnchor,
                           trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }
    private func setupHeights(){
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        headerMaxHeight = view.frame.height * 0.3 + 3 //MUST equal to the height of the view's header that is set up in the stationView
    }

    @objc func handleTableViewRefresh(_ refreshControl: UIRefreshControl){
        //load data
        //add it to the tableview
        //self.tableView.reloadData()
        // for now fake loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            refreshControl.endRefreshing()
        }
        
    }
    // scrollViewDidScroll handles the change in layout when user scrolls
    // offset starts at 0.0
    // goes negative if scroll up(tableview goes down), goes positive if scrolls down(tableView goes up)
    // offet can either be too high(keep maximum offset), to little(keep minimum offstet) or inbetween(can be adjusted)
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y_offset: CGFloat = scrollView.contentOffset.y
        guard  let headerViewTopConstraint = stationView.topViewContainerTopConstraint else {return}
        let newConstant = headerViewTopConstraint.constant - y_offset
        
        //when scrolling up
        if newConstant <= -headerMaxHeight {
            headerViewTopConstraint.constant = -headerMaxHeight
        //when scrolling down
        }else if newConstant >= 0{
            headerViewTopConstraint.constant = 0
        }else{//inbetween we want to adjust the position of the header
            headerViewTopConstraint.constant = newConstant
            scrollView.contentOffset.y = 0 //to smooth out scrolling
        }
    }
}
extension StationsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == stationView.tableViewAndTableView?.listTableView{
            return 10
        }else{
            return posts?.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == stationView.tableViewAndTableView?.listTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: listTableViewCellID, for: indexPath)
            cell.textLabel?.text = "UCSC \(indexPath.row)"
            cell.imageView?.image = UIImage(named: "sslug")
            return cell
        }else {
            switch posts?[indexPath.row].imageURL {
            case nil:
                if let cell = tableView.dequeueReusableCell(withIdentifier: PostCellWithoutImage.cellID, for: indexPath) as? PostCellWithoutImage{
                    addData(toCell: cell, withIndex: indexPath.row)
                    cell.selectionStyle = .none
                    return cell
                }
            default:
                if let cell = tableView.dequeueReusableCell(withIdentifier: PostCellWithImage.cellID, for: indexPath) as? PostCellWithImage{
                    cell.postUIImageView.image = nil
                    addData(toCell: cell, withIndex: indexPath.row)
                    cell.selectionStyle = .none
                    return cell
                }
            }
        }
        return UITableViewCell()
    }
    private func addData(toCell cell: PostCellWithoutImage, withIndex index: Int ){
        cell.titleUILabel.text =  posts?[index].title
        cell.titleUILabel.text =  posts?[index].title
        cell.previewUILabel.text =  posts?[index].text
        cell.authorUILabel.text =  posts?[index].userInfo.name
        cell.likesLabel.text = "\(posts?[index].likes ?? 0)"
        cell.commentsUILabel.text = "0"
        cell.dateUILabel.text = "\(index)h"
        
    }
    private func addData(toCell cell: PostCellWithImage, withIndex index: Int ){
        cell.titleUILabel.text =  posts?[index].title
        cell.titleUILabel.text =  posts?[index].title
        cell.previewUILabel.text =  posts?[index].text
        cell.authorUILabel.text =  posts?[index].userInfo.name
        cell.likesLabel.text = "\(posts?[index].likes ?? 0)"
        cell.commentsUILabel.text = "0"
        cell.dateUILabel.text = "\(index)h"
        NetworkManager.shared.getAsynchImage(withURL: posts?[index].imageURL) { (image, error) in
            DispatchQueue.main.async {
                cell.postUIImageView.image = image
            }
        }
    }
}
extension StationsViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
    }
}
