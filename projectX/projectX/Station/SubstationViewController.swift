//
//  RegularStationViewController.swift
//  projectX
//
//  Created by Radomyr Bezghin on 2/10/21.
//  Copyright © 2021 Radomyr Bezghin. All rights reserved.
//

import UIKit

class SubstationViewController: BaseStationViewController {
    ///collectionViewController responsible for the feed.
    private var popularFeedController: FeedCollectionViewController!
    private var missionsController: FeedCollectionViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func setupFeedsWithUserData(_ user: User?){
        popularFeedController.setupFeed(feedType: .stationFeed, paginatorId: self.station.id, userID: user?.id)
        missionsController.setupFeed(feedType: .stationFeed, paginatorId: self.station.id, userID: user?.id)
    }
    override func setupSegmentedStackWithFeeds(){
        missionsController = FeedCollectionViewController()
        popularFeedController = FeedCollectionViewController()
        self.addChild(popularFeedController)
        self.addChild(missionsController)
        popularFeedController.didScrollFeedDelegate = self
        missionsController.didScrollFeedDelegate = self
        feedSegmentedControl.stackView.addArrangedSubview(popularFeedController.view)
        feedSegmentedControl.stackView.addArrangedSubview(missionsController.view)
    }
    override func setFeedNames(){
        feedSegmentedControl.itemNames = ["Lounge", "Bulletin Board"]
    }
}
