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
    
    var headerHeight: CGFloat?
    
    var headerTopConstraint: NSLayoutConstraint!
    
    
    ///collectionViewController responsible for the feed.
    private var feedCollectionViewController: FeedCollectionViewController!
    private var newFeedController: FeedCollectionViewController!
    
    //TODO: not implemented (searching isn't straightforward with firestore)
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var user: User?
    
    private var userSubscription: AnyCancellable!
    
    ///segmented control that holds feeds
    private lazy var feedSegmentedControl: SegmentedControlWithStackView = {
        let control = SegmentedControlWithStackView(frame: self.view.frame, itemNames: ["Lounge", "Bus Stop"])
        return control
    }()
    override func viewDidAppear(_ animated: Bool) {
        if !UserManager.shared().isNewUser()
        {
            showWelcomeScreen()
        }
    }
    override func viewDidLoad() {
        view.backgroundColor = Constants.Colors.mainBackground
        super.viewDidLoad()
        setupNavigationBar()
        setupFeedController()
        setUserAndSubscribeToUpdates()
        presentLoginIfNeeded()
    }
    private func showWelcomeScreen()
    {
        let vc = WelcomeScreenVC()
        vc.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if (feedSegmentedControl.leftButton.frame.height != 0 && headerHeight == nil){
            
            headerHeight = feedSegmentedControl.leftButton.frame.height
        }
    }
    private func setupFeedController(){
        view.addSubview(feedSegmentedControl)
        feedSegmentedControl.addAnchors(top: nil,
                                        leading: view.leadingAnchor,
                                        bottom: view.bottomAnchor,
                                        trailing: view.trailingAnchor,
                                        padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        headerTopConstraint = feedSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
        headerTopConstraint.isActive = true
        
        feedCollectionViewController = FeedCollectionViewController()
        feedCollectionViewController.didScrollFeedDelegate = self
        self.add(feedCollectionViewController)//add feedController as a child

        newFeedController = FeedCollectionViewController()
        newFeedController.didScrollFeedDelegate = self
        self.add(newFeedController)//add feedController as a child
        
        feedSegmentedControl.stackView.addArrangedSubview(feedCollectionViewController.view)
        feedSegmentedControl.stackView.addArrangedSubview(newFeedController.view)
        
    }
    private func setUserAndSubscribeToUpdates(){
        switch UserManager.shared().state {
        case .loading:
            print("user is loading ")//wait for update
        case .signedIn(let user):
            self.user = user
            feedCollectionViewController.setupFeed(feedType: .lounge(nil), userID: user.id ?? nil)
            newFeedController.setupFeed(feedType: .busStop(nil), userID: user.id ?? nil)
        case .signedOut:
            print("display nothing")//display default data
            feedCollectionViewController.setupFeed(feedType: .lounge(nil))
            newFeedController.setupFeed(feedType: .busStop(nil), userID: user?.id ?? nil)
        }
        userSubscription = UserManager.shared().userPublisher.sink { (user) in
            self.user = user
            self.feedCollectionViewController.setupFeed(feedType: .lounge(nil), userID: user?.id)
            self.newFeedController.setupFeed(feedType: .busStop(nil), userID: user?.id ?? nil)
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
        navigationController?.setNavigationToViewColor()
        super.viewWillAppear(animated)
    }
    private func setupNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.titleView = UISearchBar()
        //Disable search bar interaction
        navigationItem.titleView?.isUserInteractionEnabled = false
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
            vc = RegularStationViewController(station: station)
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
