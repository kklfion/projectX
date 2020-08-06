//
//  StationsVC.swift
//  projectX
//
//  Created by Radomyr Bezghin on 8/3/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

class StationsVC: UITableViewController {
    
    let seachView: UISearchBar = {
        let sb = UISearchBar()
        sb.showsCancelButton = true
        
        return sb
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
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

}

extension StationsVC: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
}
