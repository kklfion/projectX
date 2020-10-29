//
//  StationsViewController.swift
//  projectX
//
//  Created by Radomyr Bezghin on 10/21/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit
/// controller for a parent station. It will display posts of its subStations and lists of substations
class ParentStationViewController: UIViewController, UIScrollViewDelegate {

    let listTableViewCellID = "listTableViewCellID"
    
    var station: Station?
    
    private var posts = [Post]()
    private var subStations = [Station]()
    
    var headerMaxHeight: CGFloat!
    var statusBarHeight: CGFloat!

    lazy var stationView: StationView = {
        let view = StationView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: self.view.frame.width,
                                              height: self.view.frame.height),
                                type: station?.stationType ?? .parentStation)
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
        getDataForStation()
        setupStationHeaderWithStation()
    }
    /// loads substations and then loads posts of those substations, sorts posts by date
    private func getDataForStation(){
        DispatchQueue.global(qos: .userInitiated).async {
            let group = DispatchGroup()
            //load stations that have parent station as substation
            group.enter()
            let query = NetworkManager.shared.db.stations.whereField(Fields.parentStationID.rawValue, isEqualTo: self.station?.id ?? "")
            NetworkManager.shared.getDocumentsFor(query: query) { (documents: [Station]?, error) in
                if documents != nil {
                    self.subStations.append(contentsOf: documents!)
                }else {
                    print(error?.localizedDescription ?? "Error loading stations")
                }
                group.leave()
            }
            group.wait()
            //load posts for those substations
            for station in self.subStations{
                guard let  id = station.id else {return}
                group.enter()
                NetworkManager.shared.getPostsForStation(id) { (posts, error) in
                    if error != nil{
                        print("Error loading posts for station \(String(describing: error?.localizedDescription))")
                    }else if posts != nil{
                        self.posts.append(contentsOf: posts!)
                    }
                    group.leave()
                }
            }
            group.wait()
            //sort them by date
            self.posts.sort { (first, second) in
                return first.date > second.date
            }
            DispatchQueue.main.async {
                self.stationView.tableViewAndTableView?.listTableView.reloadData()
                self.stationView.tableViewAndTableView?.loungeTableView.reloadData()
            }
        }
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
extension ParentStationViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == stationView.tableViewAndTableView?.listTableView{
            return subStations.count
        }else{
            return posts.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == stationView.tableViewAndTableView?.listTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: listTableViewCellID, for: indexPath)
            addData(toCell: cell, withIndex: indexPath.row)
            return cell
        }else {
            switch posts[indexPath.row].imageURL {
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
    private func addData(toCell cell: UITableViewCell, withIndex index: Int ){
        cell.textLabel?.text = "\(subStations[index].stationName ?? "college")"
        NetworkManager.shared.getAsynchImage(withURL: subStations[index].frontImageURL) { (image, error) in
            if image != nil {
                DispatchQueue.main.async {
                    cell.imageView?.image = image
                }
            }
        }
        
        
    }
    private func addData(toCell cell: PostCellWithoutImage, withIndex index: Int ){
        cell.titleUILabel.text =  posts[index].title
        cell.titleUILabel.text =  posts[index].title
        cell.previewUILabel.text =  posts[index].text
        cell.authorUILabel.text =  posts[index].userInfo.name
        cell.likesLabel.text = "\(posts[index].likes)"
        cell.commentsUILabel.text = "0"
        cell.dateUILabel.text = "\(index)h"
        cell.stationButton.setTitle(posts[index].stationName, for: .normal)
        
    }
    private func addData(toCell cell: PostCellWithImage, withIndex index: Int ){
        cell.titleUILabel.text =  posts[index].title
        cell.titleUILabel.text =  posts[index].title
        cell.previewUILabel.text =  posts[index].text
        cell.authorUILabel.text =  posts[index].userInfo.name
        cell.likesLabel.text = "\(posts[index].likes)"
        cell.commentsUILabel.text = "0"
        cell.dateUILabel.text = "\(index)h"
        cell.stationButton.setTitle(posts[index].stationName, for: .normal)
        NetworkManager.shared.getAsynchImage(withURL: posts[index].imageURL) { (image, error) in
            DispatchQueue.main.async {
                cell.postUIImageView.image = image
            }
        }
    }
}
extension ParentStationViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
    }
}
