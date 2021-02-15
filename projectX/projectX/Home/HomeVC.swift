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
        let control = SegmentedControlWithStackView(frame: self.view.frame, itemNames: ["Lounge", "New"])
        return control
    }()

    override func viewDidLoad() {
        view.backgroundColor = Constants.Colors.mainBackground
        super.viewDidLoad()
        setupNavigationBar()
        setupHeights(viewHeight: 85, extraHeight: 0)
        setupFeedController()
        setUserAndSubscribeToUpdates()
        
        presentLoginIfNeeded()
        
    }
    func doit(){
        let names = ["Barstool", "Beta Station", "Confession", "Life", "Mental", "Movie", "Rant"]
        let imagesURL = [
        URL(string: "https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/stationsImages%2FsecondaryImages%2Fbarstool.png?alt=media&token=2ca8f8cd-ac2e-4e75-a297-74857659ca29")!,
            URL(string: "https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/stationsImages%2FsecondaryImages%2Fbeta.png?alt=media&token=2373d8e5-10bb-4e69-ba10-dfdd2245804a")!,
            URL(string: "https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/stationsImages%2FsecondaryImages%2Fconfession.png?alt=media&token=c026ad8e-362a-447d-b270-c11f3188874a")!,
            URL(string: "https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/stationsImages%2FsecondaryImages%2Flife.png?alt=media&token=2cccfdcf-f2fd-42c0-8183-63c86efe0323")!,
            URL(string: "https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/stationsImages%2FsecondaryImages%2Fmental.png?alt=media&token=c4d88d0b-3cf3-44d6-b1a3-9b26220bbd0d")!,
            URL(string: "https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/stationsImages%2FsecondaryImages%2Fmovie.png?alt=media&token=076f7911-cf09-4bb4-9f21-118f6456ef4c")!,
            URL(string: "https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/stationsImages%2FsecondaryImages%2Frant.png?alt=media&token=243070c4-fa1a-4740-a445-ef4779c6fa28")!
        ]
        let info = ["",
                    "For suggestions and possible feedback users in beta could post about and collaborate.",
                    "",
                    "",
                    "",
                    "",
                    ""
        ]
        let main = [
            "#4bbcc9",
            "#657cb5",
            "#d57f63",
            "#b18ec7",
            "#3fa7b7",
            "#dfc078",
            "#9be2d3"
        ]
        let secondary = [
            "#6fcfd4",
            "#83a1ce",
            "#e7a37e",
            "#d5c4e0",
            "#5dbaba",
            "#eedd96",
            "#b8ede4"
        ]
        for index in 0..<names.count{
            let station = Station(info: info[index],
                                  stationName: names[index],
                                  followers: 0,
                                  date: Date(),
                                  frontImageURL: imagesURL[index],
                                  backgroundImageURL: nil,
                                  mainColor: main[index],
                                  secondaryColor: secondary[index],
                                  parentStationID: nil,
                                  stationType: .station)
                    NetworkManager.shared.writeDocumentsWith(collectionType: .stations,
                                                            documents: [station])
                    {
                        result in
                    }
        }
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
        vc.view.backgroundColor  = Constants.Colors.mainBackground
        
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
        navigationController?.setNavigationToViewColor()
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
