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
    let headerView: UIView = {
        let view = UIView()
        
        return view
    }()
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: <#T##String#>)
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        navigationItem.titleView = seachView
        tableView.tableHeaderView =
    }

}

extension StationsVC: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
}
