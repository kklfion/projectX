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
import Combine

class HomeTableVC: UIViewController, SlidableTopViewProtocol{
    
    var headerMaxHeight: CGFloat!
    
    var statusBarHeight: CGFloat!
    
    var topViewTopConstraint: NSLayoutConstraint!
    
    ///collectionViewController responsible for the feed.
    private var feedCollectionViewController: FeedCollectionViewController!
    
    //TODO: not implemented (searching isn't straightforward with firestore)
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var user: User?
    
    private var userSubscription: AnyCancellable!
    
    ///segmented control that holds feeds
    private lazy var feedSegmentedControl: SegmentedControlWithStackView = {
        let control = SegmentedControlWithStackView(frame: self.view.frame, itemNames: ["Lounge", "Bus Stop"])
        return control
    }()

    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        setupNavigationBar()
        setupHeights(viewHeight: 85, extraHeight: 0)
        setupFeedController()
        setUserAndSubscribeToUpdates()
        
        presentLoginIfNeeded()
    }
    private func setupFeedController(){
        view.addSubview(feedSegmentedControl)
        feedSegmentedControl.addAnchors(top: nil,
                                        leading: view.leadingAnchor,
                                        bottom: view.bottomAnchor,
                                        trailing: view.trailingAnchor,
                                        padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        topViewTopConstraint = feedSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
        topViewTopConstraint.isActive = true
        
        feedCollectionViewController = FeedCollectionViewController()
        feedCollectionViewController.didScrollFeedDelegate = self
        self.add(feedCollectionViewController)//add feedController as a child

        let vc = UIViewController() //instead of the missions vc
        vc.view.backgroundColor  = .white
        
        feedSegmentedControl.stackView.addArrangedSubview(feedCollectionViewController.view)
        feedSegmentedControl.stackView.addArrangedSubview(vc.view)
        
    }
    private func setUserAndSubscribeToUpdates(){
        switch UserManager.shared().state {
        case .loading:
            print("user is loading ")//wait for update
        case .signedIn(let user):
            self.user = user
            feedCollectionViewController.setupFeed(feedType: .generalFeed, userID: user.id ?? nil)
        case .signedOut:
            print("display nothing")//display default data
            feedCollectionViewController.setupFeed(feedType: .generalFeed)
        }
        userSubscription = UserManager.shared().userPublisher.sink { (user) in
            self.user = user
            self.feedCollectionViewController.setupFeed(feedType: .generalFeed, userID: user?.id)
        }
    }
}
extension HomeTableVC: DidScrollFeedDelegate{
    func didScrollFeed(_ scrollView: UIScrollView) {
        adjustHeaderPosition(scrollView, navigationController, navigationItem: navigationItem)
    }
}
//MARK: - Navigation Bar setup
extension HomeTableVC{
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationToWhite()
        super.viewWillAppear(animated)
    }
    private func setupNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.titleView = UISearchBar()
    }
}
//MARK: - SideBarStationSelectionDelegate
extension HomeTableVC: SideBarStationSelectionDelegate{
    func didTapSidebar(station: Station) {
        let vc: BaseStationViewController
        switch station.stationType {
        case .parentStation:
            vc = ParentStationViewController(station: station)
        case .subStation:
            vc = SubstationViewController(station: station)
        case .station:
            vc = BaseStationViewController(station: station)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
//MARK: - Navigation
extension HomeTableVC{
    ///when app is loaded and user isnt signed in, login screen is presented
    private func presentLoginIfNeeded(){
        if Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let navvc = UINavigationController(rootViewController: vc)
            navvc.modalPresentationStyle = .fullScreen
            self.tabBarController?.present(navvc, animated: true)
        }
    }
}
