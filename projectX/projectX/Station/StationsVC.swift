//
//  StationsVC.swift
//  projectX
//
//  Created by Radomyr Bezghin on 8/3/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

class StationsVC: UIViewController, UIScrollViewDelegate {
    
    var headerMaxHeight: CGFloat!
    var statusBarHeight: CGFloat!
    
    let CellData = [Post]()
    lazy var newView: StationsView = {
        let view = StationsView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
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
        setupTableView(tableView: newView.stationsTableView)
        
       
    }
    func setupTableView(tableView: UITableView){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(PostCellWithImage.self, forCellReuseIdentifier: PostCellWithImage.cellID)
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(handleTableViewRefresh(_:)), for: UIControl.Event.valueChanged)
    }
    func setupView(){
        navigationItem.titleView = seachView
        view.addSubview(newView)
        newView.addAnchors(top: view.safeAreaLayoutGuide.topAnchor,
                           leading: view.safeAreaLayoutGuide.leadingAnchor,
                           bottom: view.bottomAnchor,
                           trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }
    func setupHeights(){
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
        guard  let headerViewTopConstraint = newView.topViewContainerTopConstraint else {return}
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
extension StationsVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CellData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCellWithImage.cellID, for: indexPath) as? PostCellWithImage else {
            fatalError("Wrong cell at cellForRowAt? ")
        }
        //        if tableView == homeView.homeTableView{
        //
        //        }else if  tableView == homeView.recommendingTableView{
        //        }
        addData(toCell: cell, withIndex: indexPath.row)
        return cell
    }
    func addData(toCell cell: PostCellWithImage, withIndex index: Int ){
        cell.titleUILabel.text =  CellData[index].title
        cell.previewUILabel.text =  CellData[index].text
        cell.authorUILabel.text =  CellData[index].userInfo.name
        cell.likesLabel.text =  String(CellData[index].likes)
        cell.commentsUILabel.text =  String(CellData[index].commentCount)
        //cell.UID =  CellData[index].postID
        cell.dateUILabel.text = "\(index)h"
        if CellData[index].imageURL != nil{
            let temp = UIImageView()
            temp.load(url: CellData[index].imageURL!)
            cell.postUIImageView.image = temp.image
            //cell.withImageViewConstraints()
        }else{
            //change cell constraints so that text takes the extra space
            cell.postUIImageView.image = nil
            //cell.noImageViewConstraints()
        }
    }
}
extension StationsVC: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
    }
}
