//
//  FeedCollectionViewController.swift
//  projectX
//
//  Created by Radomyr Bezghin on 1/12/21.
//  Copyright © 2021 Radomyr Bezghin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FeedCollectionViewController: UICollectionViewController {
    
    var dataSource: UICollectionViewDiffableDataSource<FeedSection, Post>!
    
    init(){
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        print("and here")
        super.viewDidLoad()
    }
}
