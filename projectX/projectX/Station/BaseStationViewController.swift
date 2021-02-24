//
//  StationsVC.swift
//  projectX
//
//  Created by Radomyr Bezghin on 8/3/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//
import UIKit

import Combine

///is a super class for all stations. Don't create is directly, rather use it's subclasses.
///Is responsible for general UI and its subclasses are responsible for different feeds
class BaseStationViewController: UIViewController, SlidableTopViewProtocol {
    
    //MARK: - SlidableTopViewProtocol variables
    var headerHeight: CGFloat?
    
    var headerTopConstraint: NSLayoutConstraint!
    
    lazy var stationHeaderHeight = view.frame.height * 0.4
    //MARK: - other variables
    ///presented Station, either a substation or a regular station
    internal var station: Station
    
    ///posts for Station are loaded after viewcontroller was loaded
    private var posts = [Post]()
    
    ///missions for Station are loaded after viewcontroller was loaded
    private var missions = [Mission]()
    
    ///collectionViewController responsible for the feed.
    private var feedCollectionViewController: FeedCollectionViewController!
    
    private var user: User?

    private var userSubscription: AnyCancellable!
    
    lazy var stationView: StationView = {
        let view = StationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: stationHeaderHeight))
        return view
    }()

    ///segmented control that holds feeds
    lazy var feedSegmentedControl: SegmentedControlWithStackView = {
        let control = SegmentedControlWithStackView(frame: self.view.frame, itemNames: ["Lounge", "Bus Stop"])
        return control
    }()
    
    init(station: Station){
        self.station = station
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    internal func setupFeedsWithUserData(_ user: User?){
        fatalError("Must Override")
    }
    internal func setupSegmentedStackWithFeeds(){
        fatalError("Must Override")
    }
    internal func setFeedNames(){
        fatalError("Must Override")
    }
}
extension BaseStationViewController{
    override func viewDidLoad() {
        view.backgroundColor = Constants.Colors.mainBackground
        navigationItem.largeTitleDisplayMode = .never
        setupView()
        setupSegmentedStackWithFeeds()
        setUserAndSubscribeToUpdates()
        setupStationHeaderWithStationData()
        checkIfStationFollowed()
        setFeedNames()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationToTransparent()
        super.viewWillAppear(animated)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !headerHeightWasSet() && feedSegmentedControl.leftButton.frame.height != 0 && stationView.frame.height != 0 {
            let headerHeight = feedSegmentedControl.leftButton.frame.height + stationView.frame.height
            let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0
            let navBarHeight = self.navigationController?.navigationBar.frame.height ?? 0.0
            let safeAreaInset = statusBarHeight + navBarHeight
            setupHeaderHeight(header: headerHeight, safeArea: safeAreaInset)
        }
    }
    private func setUserAndSubscribeToUpdates(){
        switch UserManager.shared().state {
        case .loading:
            print("user is loading ")//wait for update
        case .signedIn(let user):
            self.user = user
            setupFeedsWithUserData(user)
        case .signedOut:
            setupFeedsWithUserData(user)
        }
        userSubscription = UserManager.shared().userPublisher.sink { (user) in
            self.user = user
            self.setupFeedsWithUserData(user)
        }
    }
    ///if user is signed in station can be followed/not followed
    //FIXME: I dont this this is working properly lol
    private func checkIfStationFollowed(){
//        switch UserManager.shared().state{
//        case .signedIn(_):
//            //stationView.followedButton()
//        case .signedOut:
//            //stationView.notFollowedButton()
//        case .loading:
//            print("loading")
//        }
    }
    private func setupStationHeaderWithStationData(){
        stationView.changeFollowerCount(by: station.followers)
        NetworkManager.shared.getAsynchImage(withURL: station.backgroundImageURL) { (image, error) in
            if image != nil {
                DispatchQueue.main.async {
                    self.stationView.backgroundImageView.image = image
                }
            }
        }
        NetworkManager.shared.getAsynchImage(withURL: station.frontImageURL) { (image, error) in
            if image != nil {
                DispatchQueue.main.async {
                    self.stationView.frontImageView.image = image
                }
            }
        }
        stationView.setupGradient(mainColorHex: station.mainColorHex, secondaryColorHex: station.secondaryColorHex)
        stationView.stationInfoLabel.text = station.info
        stationView.stationNameLabel.text = station.stationName
        self.navigationItem.title = station.stationName

    }
    private func setupView(){
        view.addSubview(stationView)
        stationView.addAnchors(top: nil,
                               leading: view.leadingAnchor,
                               bottom: nil,
                               trailing: view.trailingAnchor)
        stationView.heightAnchor.constraint(equalToConstant: stationHeaderHeight).isActive = true
        headerTopConstraint = stationView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
        headerTopConstraint.isActive = true
        stationView.followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        
        guard let id = station.id else {return}
        if UserManager.shared().isStationFollowed(stationID: id) != nil {
            stationView.setFollowButtonToFollowed()
        } else {
            stationView.setFollowButtonToNotFollowed()
        }
        
        view.addSubview(feedSegmentedControl)
        feedSegmentedControl.addAnchors(top: stationView.bottomAnchor,
                                        leading: view.leadingAnchor,
                                        bottom: view.bottomAnchor,
                                        trailing: view.trailingAnchor,
                                        padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
}
//MARK: - Handlers
extension BaseStationViewController{
    /// when follow button is tapped followedStation should be added/removes in UserManager and in the Firestore
    @objc private func didTapFollowButton(){
        guard let stationID = station.id else {return}
        guard  let userID = UserManager.shared().user?.userID else {return}
        //if station is followed - unfollow it
        if let followedStationDocID = UserManager.shared().isStationFollowed(stationID: stationID)?.id{
            //delete it from db
            UserManager.shared().removeFollowedStation(stationID: stationID)
            self.stationView.notFollowedButton()
            self.station.followers -= 1
            self.stationView.changeFollowerCount(by: self.station.followers)
            NetworkManager.shared.deleteDocumentsWith(collectionType: .followedStations, documentID: followedStationDocID) { (error) in
                if error != nil {
                    print(error?.localizedDescription ?? "error deleting followedStation")
                }else{

                    NetworkManager.shared.incrementDocumentValue(collectionType: .stations,
                                                                 documentID: stationID,
                                                                 value: Double(-1),
                                                                 field: .followers)
                }
            }
        }else{//else follow it
            var document = FollowedStation(userID: userID, stationID: stationID, stationName: station.stationName, date: Date())
            self.station.followers += 1
            self.stationView.changeFollowerCount(by: self.station.followers)
            self.stationView.followedButton()
            NetworkManager.shared.writeDocumentReturnReference(collectionType: .followedStations, document: document) { (referenceID, error) in
                if error != nil {
                    print(error?.localizedDescription ?? "error creating followedStation")
                }else if (referenceID != nil){
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
extension BaseStationViewController: DidScrollFeedDelegate{
    func didScrollFeed(_ scrollView: UIScrollView) {
        adjustHeaderPosition(scrollView, navigationController, navigationItem: navigationItem)
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
