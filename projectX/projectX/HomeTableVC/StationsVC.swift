//
//  StationsVC.swift
//  projectX
//
//  Created by Radomyr Bezghin on 8/3/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

class StationsVC: UIViewController {
    
    let CellData = FakePostData().giveMeSomeData()
    
    let seachView: UISearchBar = {
        let sb = UISearchBar()
        sb.showsCancelButton = true
        
        return sb
    }()
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        let newView = createView()
        setupTableView(tableView: newView.stationsTableView)
        navigationItem.titleView = seachView
        view = newView
    }
    func setupTableView(tableView: UITableView){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostCell.self, forCellReuseIdentifier: Constants.PostCellID)
    }

    func createView()-> StationsView{
        let view = StationsView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        return view
    }
    
    


}
extension StationsVC: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
extension StationsVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CellData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
