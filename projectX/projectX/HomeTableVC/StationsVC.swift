//
//  StationsVC.swift
//  projectX
//
//  Created by Radomyr Bezghin on 8/3/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

class StationsVC: UITableViewController {
    
    let CellData = FakePostData().giveMeSomeData()
    
    let seachView: UISearchBar = {
        let sb = UISearchBar()
        sb.showsCancelButton = true
        
        return sb
    }()
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        tableView.register(PostCell.self, forCellReuseIdentifier: Constants.PostCellID)
        setupHeaderView()
        navigationItem.titleView = seachView
    
    }
    func setupHeaderView(){
        let headerView = createHeaderView()
        tableView.tableHeaderView = headerView
    }
    func createHeaderView()-> UIView{
        let view = StationsView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height * 1/3))
        return view
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CellData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.PostCellID, for: indexPath) as? PostCell else {
            fatalError("Wrong cell at cellForRowAt? ")
        }
//        if tableView == homeView.homeTableView{
//
//        }else if  tableView == homeView.recommendingTableView{
//        }
        addData(toCell: cell, withIndex: indexPath.row)
        return cell
    }
    func addData(toCell cell: PostCell, withIndex index: Int ){
        cell.titleUILabel.text =  CellData[index].title
        cell.previewUILabel.text =  CellData[index].preview
        cell.authorUILabel.text =  CellData[index].author
        cell.likesUILabel.text =  String(CellData[index].likesCount)
        cell.commentsUILabel.text =  String(CellData[index].commentsCount)
        //cell.UID =  CellData[index].postID
        cell.dateUILabel.text = "\(index)h"
        if CellData[index].image != nil{
            //this cell will have an image
            cell.postUIImageView.image = CellData[index].image
            cell.withImageViewConstraints()
        }else{
            //change cell constraints so that text takes the extra space
            cell.postUIImageView.image = nil
            cell.noImageViewConstraints()
        }
    }

}
extension StationsVC: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
}
