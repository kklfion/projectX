//
//  StationsVC.swift
//  projectX
//
//  Created by Radomyr Bezghin on 8/3/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//
import UIKit
import Combine

class StationViewController: UIViewController, DidScrollFeedDelegate {
    func didScrollFeed(_ scrollView: UIScrollView) {
        adjustHeaderPosition(scrollView)
    }
    ///presented Station, either a substation or a regular station
    var station: Station?
    
    ///posts for Station are loaded after viewcontroller was loaded
    private var posts = [Post]()
    
    ///missions for Station are loaded after viewcontroller was loaded
    private var missions = [Mission]()
    
    ///collectionViewController responsible for the feed.
    private var feedCollectionViewController: FeedCollectionViewController!
    
    private var user: User?
    
    private var userSubscription: AnyCancellable!

    ///used for calculating sliding up/down header when scrolling
    var headerMaxHeight: CGFloat!
    var statusBarHeight: CGFloat!
    
    lazy var stationView: StationView = {
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        let view = StationView(frame: frame, type: .subStation)
        return view
    }()

    override func viewDidLoad() {
        view.backgroundColor = .white
        setupFeedVCs()
        setUserAndSubscribeToUpdates()
        setupView()
        setupHeights()
        setupStationHeaderWithStation()
        checkIfStationFollowed()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = Constants.Colors.gamingBackground
        navBarAppearance.shadowImage = UIImage()
        navBarAppearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    private func setUserAndSubscribeToUpdates(){
        switch UserManager.shared().state {
        case .loading:
            print("user is loading ")//wait for update
        case .signedIn(let user):
            self.user = user
            feedCollectionViewController.setupFeed(feedType: .stationFeed, paginatorId: station?.id, userID: user.id)
        case .signedOut:
            print("display nothing")//display default data
            feedCollectionViewController.setupFeed(feedType: .stationFeed, paginatorId: station?.id, userID: user?.id)
        }
        userSubscription = UserManager.shared().userPublisher.sink { (user) in
            self.user = user
            self.feedCollectionViewController.setupFeed(feedType: .stationFeed, paginatorId: self.station?.id, userID: user?.id)
        }
    }
    private func setupFeedVCs(){
        let vc = UIViewController() //instead of the missions vc
        vc.view.backgroundColor  = .white
        feedCollectionViewController = FeedCollectionViewController()
        self.addChild(feedCollectionViewController)
        feedCollectionViewController.didScrollFeedDelegate = self
        stationView.tableViewAndCollectionView?.stackView.addArrangedSubview(feedCollectionViewController.view)
        stationView.tableViewAndCollectionView?.stackView.addArrangedSubview(vc.view)
    }
    ///if user is signed in station can be followed/not followed
    private func checkIfStationFollowed(){
        switch UserManager.shared().state{
        case .signedIn(_):
            stationView.followedButton()
        case .signedOut:
            stationView.notFollowedButton()
        case .loading:
            print("loading")
        }
    }
//    ///fetches posts and missions for station
//    private func loadDataForStation(){
//        guard let  id = station?.id else {return}
//        //fetch posts
//        var query = NetworkManager.shared.db.posts.whereField(FirestoreFields.stationID.rawValue, isEqualTo: id)
//        NetworkManager.shared.getDocumentsForQuery(query: query) { (posts: [Post]?, error) in
//            if error != nil{
//                print("Error loading posts for station \(String(describing: error?.localizedDescription))")
//            }else if posts != nil{
//                self.posts = posts!
//                self.stationView.tableViewAndCollectionView?.loungeTableView.reloadData()
//            }
//        }
//        //fetch missions
//        query = NetworkManager.shared.db.missions.whereField(FirestoreFields.stationID.rawValue, isEqualTo: id)
//        NetworkManager.shared.getDocumentsForQuery(query: query) { (missions: [Mission]?, error) in
//            if error != nil{
//                print("Error loading missions for station \(String(describing: error?.localizedDescription))")
//            }else if missions != nil{
//                self.missions = missions!
//                self.stationView.tableViewAndCollectionView?.bulletinBoardCollectionView.reloadData()
//            }
//        }
//    }
//    private func setupBulletinBoardTableView(){
//        stationView.tableViewAndCollectionView?.bulletinBoardCollectionView.delegate = self
//        stationView.tableViewAndCollectionView?.bulletinBoardCollectionView.dataSource = self
//        stationView.tableViewAndCollectionView?.bulletinBoardCollectionView.register(BoardCell.self, forCellWithReuseIdentifier: BoardCell.cellID)
//        stationView.tableViewAndCollectionView?.bulletinBoardCollectionView.refreshControl = UIRefreshControl()
//        //stationView.tableViewsView?.bulletinBoardCollectionView.refreshControl?.addTarget(self, action: #selector(handleTableViewRefresh(_:)), for: UIControl.Event.valueChanged)
//    }

    private func setupStationHeaderWithStation(){
        stationView.changeFollowerCount(by: station?.followers ?? 0)
        NetworkManager.shared.getAsynchImage(withURL: station?.backgroundImageURL) { (image, error) in
            if image != nil {
                DispatchQueue.main.async {
                    self.stationView.backgroundImageView.image = image
                }
            }
        }
        NetworkManager.shared.getAsynchImage(withURL: station?.frontImageURL) { (image, error) in
            if image != nil {
                DispatchQueue.main.async {
                    self.stationView.frontImageView.image = image
                }
            }
        }
        stationView.stationInfoLabel.text = station?.info
        stationView.stationNameLabel.text = station?.stationName
        self.navigationItem.title = station?.stationName ?? "Station"

    }
    private func setupView(){
        view.addSubview(stationView)
        stationView.followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        stationView.addAnchors(top: view.safeAreaLayoutGuide.topAnchor,
                           leading: view.safeAreaLayoutGuide.leadingAnchor,
                           bottom: view.bottomAnchor,
                           trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }
    private func setupHeights(){
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        headerMaxHeight = view.frame.height * 0.3 + 3 //MUST equal to the height of the view's header that is set up in the stationView
    }
    // adjustHeaderPosition handles the change in layout when user scrolls
    // offset starts at 0.0
    // goes negative if scroll up(tableview goes down), goes positive if scrolls down(tableView goes up)
    // offet can either be too high(keep maximum offset), to little(keep minimum offstet) or inbetween(can be adjusted)
    private func adjustHeaderPosition(_ scrollView: UIScrollView){
        let y_offset: CGFloat = scrollView.contentOffset.y
        guard  let headerViewTopConstraint = stationView.topViewContainerTopConstraint else {return}
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
//extension StationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.view.frame.width/2.2, height: self.view.frame.width*0.6)
//        }
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return missions.count / 2
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 2
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let tryCell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardCell.cellID, for: indexPath) as? BoardCell
//        guard let cell = tryCell else {
//            return UICollectionViewCell()
//        }
//
//        cell.descriptionLabel.text = missions[indexPath.row].text
//        NetworkManager.shared.getAsynchImage(withURL: missions[indexPath.row].imageURL) { (image, error) in
//            if image != nil {
//                DispatchQueue.main.async {
//                    cell.boardImageView.image = image
//                }
//            }
//        }
//        return cell
//    }
//}
//MARK: Handlers
extension StationViewController{
    /// when follow button is tapped followedStation should be added/removes in UserManager and in the Firestore
    @objc private func didTapFollowButton(){
        guard let station = station else {return}
        guard let stationID = station.id else {return}
        guard  let userID = UserManager.shared().user?.userID else {return}
        //if station is followed - unfollow it
        if let followedStation = UserManager.shared().isStationFollowed(stationID: stationID){
            //delete it from db
            guard let followedStationID = followedStation.id else {return}
            NetworkManager.shared.deleteDocumentsWith(collectionType: .followedStations, documentID: followedStationID) { (error) in
                if error != nil {
                    print(error?.localizedDescription ?? "error deleting followedStation")
                }else{
                    UserManager.shared().removeFollowedStation(stationID: stationID)
                    self.stationView.notFollowedButton()
                    self.station?.followers -= 1
                    self.stationView.changeFollowerCount(by: self.station?.followers ?? 0)
                    NetworkManager.shared.incrementDocumentValue(collectionType: .stations,
                                                                 documentID: stationID,
                                                                 value: Double(-1),
                                                                 field: .followers)
                }
            }

        }else{//else follow it
            var document = FollowedStation(userID: userID, stationID: stationID, stationName: station.stationName, date: Date())
            NetworkManager.shared.writeDocumentReturnReference(collectionType: .followedStations, document: document) { (referenceID, error) in
                if error != nil {
                    print(error?.localizedDescription ?? "error creating followedStation")
                }else if (referenceID != nil){
                    self.station?.followers += 1
                    self.stationView.changeFollowerCount(by: self.station?.followers ?? 0)
                    self.stationView.followedButton()
                    document.id = referenceID
                    UserManager.shared().addFollowedStation(followedStation: document)
                    NetworkManager.shared.incrementDocumentValue(collectionType: .stations,
                                                                 documentID: stationID,
                                                                 value: Double(1),
                                                                 field: .followers)
                }
            }
        }
  
    }
}
