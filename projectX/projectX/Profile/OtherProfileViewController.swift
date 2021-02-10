//
//  OtherProfileViewController.swift
//  projectX
//
//  Created by Radomyr Bezghin on 10/22/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit
import FirebaseAuth
import Combine

enum ProfileType{
    case otherProfile
    case personalProfile
}
protocol SlidableTopViewProtocol: class{
    
    var headerMaxHeight: CGFloat! { get set }
    
    var statusBarHeight: CGFloat! { get set }
    
    //must be pinned to the top anchor of the view that is sliding
    var topViewTopConstraint: NSLayoutConstraint! { get set }
    
    func adjustHeaderPosition(_ scrollView: UIScrollView,_ controller: UINavigationController?, navigationItem: UINavigationItem?)
    
    func setupHeights(viewHeight: CGFloat, extraHeight: CGFloat)
    
    func isAtMaxHeight(viewHeight: CGFloat, currentOffset:CGFloat) -> Bool
    
}
extension SlidableTopViewProtocol{
    func adjustHeaderPosition(_ scrollView: UIScrollView,_ controller: UINavigationController?, navigationItem: UINavigationItem?){
        let y_offset: CGFloat = scrollView.contentOffset.y
        let topViewOffset = topViewTopConstraint.constant - y_offset
        if isAtMaxHeight(viewHeight: headerMaxHeight, currentOffset: topViewOffset){
            topViewTopConstraint.constant = -headerMaxHeight //dont move past that point
        } else if topViewOffset >= 0{//when scrolling down remain at 0
            topViewTopConstraint.constant = 0
            //controller?.isNavigationBarHidden = true
            controller?.setNavigationToTransparent()
            navigationItem?.title = ""
        }else{//inbetween we want to adjust the position of the header
            //controller?.isNavigationBarHidden = false
            controller?.setNavigationToWhite()
            navigationItem?.title = "Profile"
            topViewTopConstraint.constant = topViewOffset
            scrollView.contentOffset.y = 0 //to smooth out scrolling
        }
    }
    func isAtMaxHeight(viewHeight: CGFloat, currentOffset:CGFloat) -> Bool{
        return currentOffset <= -viewHeight
    }
    func setupHeights(viewHeight: CGFloat, extraHeight: CGFloat){
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        headerMaxHeight = viewHeight-statusBarHeight-extraHeight
    }
}

class OtherProfileViewController: UIViewController, DidScrollFeedDelegate, SlidableTopViewProtocol {
    
    lazy var profileHeight = view.frame.height * 0.4
     
    ///height of the status bar, used in calculations for the sliding up view
    var headerMaxHeight: CGFloat!
    
    ///height of the status bar, used in calculations for the sliding up view
    var statusBarHeight: CGFloat!
    
    ///to acocunt for the optional navBar
    var extraHeight: CGFloat
    
    var topViewTopConstraint: NSLayoutConstraint!
    
    func didScrollFeed(_ scrollView: UIScrollView) {
        adjustHeaderPosition(scrollView, navigationController, navigationItem: navigationItem)
    }
    ///user displayed by the controller
    var user: User?
    
    var profileType: ProfileType
    
    private var follower: Follower?
    
    private var userSubscription: AnyCancellable!
    
    ///posts that were created by user
    private var posts = [Post]()
    
    ///missions accepted by the user ? or created?
    private var missions = [Mission]()
    
    ///profile view
    private lazy var profileView: ProfileView = {
        let view = ProfileView(frame: self.view.frame)
        return view
    }()
    private lazy var loginView: NeedToLoginView = {
        let view = NeedToLoginView(frame: self.view.frame)
        return view
    }()
    
    ///segmented control that holds feeds
    private lazy var feedSegmentedControl: SegmentedControlWithStackView = {
        let control = SegmentedControlWithStackView(frame: self.view.frame, itemNames: ["Posts", "Missions"])
        return control
    }()
    
    ///feed vc
    private var feedCollectionViewController: FeedCollectionViewController!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
//        navigationController?.isNavigationBarHidden = false
    }
    ///to initialize your profile
    init() {
        self.profileType = .personalProfile
        self.extraHeight = -10 //no navbar
        super.init(nibName: nil, bundle: nil)
    }
    ///initialize profileviewcontroller with user data (to display other user profile)
    init(user: User){
        self.user = user
        self.profileType = .otherProfile
        self.extraHeight = -10 //to account for the navBar
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationToTransparent()
        self.navigationItem.title = "Profile"
        extendedLayoutIncludesOpaqueBars = true
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        setupProfileView()
        setupHeights(viewHeight: profileHeight, extraHeight: extraHeight)
        setupFeedVCs()
        switch profileType{
        case .otherProfile:
            updateProfileInformation()
            feedCollectionViewController.setupFeed(feedType: .userHistoryFeed,
                                                   paginatorId: user?.userID,
                                                   userID: user?.userID)
            checkIfUserIsFollowed()
        case .personalProfile:
            setUserAndSubscribeToUpdates()
            profileView.followButton.isHidden = true
        }
    }
    private func checkIfUserIsFollowed(){
        //load follow if exist
        guard let personalID = UserManager.shared().user?.userID else {return}
        guard let userToFollowID = user?.userID else {return}
        let query = NetworkManager.shared.db.followers
            .whereField(FirestoreFields.followingUserWithID.rawValue, isEqualTo: userToFollowID)
            .whereField(FirestoreFields.userID.rawValue, isEqualTo: personalID)
            NetworkManager.shared.getDocumentsForQuery(query: query) { (follower: [Follower]?, error) in
                if error != nil{
                    print("Error loading follower for user \(String(describing: error?.localizedDescription))")
                }else if follower != nil{
                    self.follower = follower?[0]
                    self.profileView.setFollowButtonToFollowed()
                }else{
                    self.profileView.setFollowButtonToNotFollowed()
                }
            }
    }
    private func setUserAndSubscribeToUpdates(){
        switch UserManager.shared().state {
        case .loading:
            print("user is loading ")//wait for update
            //show loading screen
        case .signedIn(let user):
            self.user = user
            self.hideLoginScreen()
            updateProfileInformation()
            feedCollectionViewController.setupFeed(feedType: .userHistoryFeed, paginatorId: user.id, userID: user.id)
        case .signedOut:
            showLoginScreen()
        }
        userSubscription = UserManager.shared().userPublisher.sink { (user) in
            if user == nil {
                self.showLoginScreen()
            } else{
                self.hideLoginScreen()
                self.user = user
                self.updateProfileInformation()
                self.feedCollectionViewController.setupFeed(feedType: .userHistoryFeed, paginatorId: user?.id, userID: user?.id)
            }

        }
    }
    private func hideLoginScreen(){
        loginView.removeFromSuperview()
    }
    private func showLoginScreen(){
        //show login screen instead
        loginView.loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        self.view.addSubview(loginView)
        loginView.addAnchors(top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor)
    }
    @objc func didTapLoginButton(){
        let vc = LoginViewController()
        let navvc = UINavigationController(rootViewController: vc)
        navvc.modalPresentationStyle = .fullScreen
        self.tabBarController?.present(navvc, animated: true)
    }
    private func setupProfileView(){
        view.addSubview(profileView)
        profileView.addAnchors(top: nil,
                               leading: view.leadingAnchor,
                               bottom: nil,
                               trailing: view.trailingAnchor)
        profileView.heightAnchor.constraint(equalToConstant: profileHeight).isActive = true
        topViewTopConstraint = profileView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
        topViewTopConstraint.isActive = true
        profileView.followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        
        view.addSubview(feedSegmentedControl)
        feedSegmentedControl.addAnchors(top: profileView.bottomAnchor,
                                        leading: view.leadingAnchor,
                                        bottom: view.bottomAnchor,
                                        trailing: view.trailingAnchor,
                                        padding: .init(top: 10, left: 0, bottom: 0, right: 0))
    }
    private func setupFeedVCs(){
        let vc = UIViewController() //instead of the missions vc
        vc.view.backgroundColor  = .white
        feedCollectionViewController = FeedCollectionViewController()
        self.addChild(feedCollectionViewController)
        feedCollectionViewController.didScrollFeedDelegate = self
        feedSegmentedControl.stackView.addArrangedSubview(feedCollectionViewController.view)
        feedSegmentedControl.stackView.addArrangedSubview(vc.view)
    }
    @objc func didTapFollowButton(){
        //need to fetch whether user was is followed
        //if followed and tapped - unfollow
        if follower != nil { //already followed / able to fetch the follow
            deleteFollowAndDecrementCounter()
        } else { //not followed or unable to fetch follow
            writeFollowAndIncrementCounter()

        }
    }
    private func  deleteFollowAndDecrementCounter(){
        guard let personalID = UserManager.shared().user?.userID else {return}
        guard let userToFollowID = user?.userID else {return}
        let query = NetworkManager.shared.db.followers
            .whereField(FirestoreFields.followingUserWithID.rawValue, isEqualTo: userToFollowID)
            .whereField(FirestoreFields.userID.rawValue, isEqualTo: personalID)
        NetworkManager.shared.getDocumentsForQuery(query: query) {(followers: [Follower]?, err) in
            if let error = err {
                print(error)
            }else if let doc = followers?.first {
                NetworkManager.shared.deleteDocumentsWith(collectionType: .followers,
                                                          documentID: doc.id ?? "") { (err) in
                    if let error = err {
                        print(error)
                    } else {
                        self.profileView.setFollowButtonToNotFollowed()
                        self.follower = nil
                        //increment followers count
                        NetworkManager.shared.incrementDocumentValue(collectionType: .users,
                                                                     documentID: userToFollowID, value: -1,
                                                                     field: .followersCount)
                    }
                }
            }
        }

    }
    private func  writeFollowAndIncrementCounter(){
        guard let personalID = UserManager.shared().user?.userID else {return}
        guard let userToFollowID = user?.userID else {return}
        let doc = Follower(userID: personalID, followingUserWithID: userToFollowID)
        NetworkManager.shared.writeDocumentsWith(collectionType: .followers,
                                                 documents: [doc]) { (err) in
            if let error = err {
                print(error)
            } else {
                //increment followers count
                self.profileView.setFollowButtonToFollowed()
                self.follower = doc
                NetworkManager.shared.incrementDocumentValue(collectionType: .users,
                                                             documentID: userToFollowID, value: 1,
                                                             field: .followersCount)
            }
        }
    }
    private func updateProfileInformation(){
        guard let user = user else{return}
        profileView.usernameLabel.text = user.name
        if let school = getSchoolFrom(email: user.email){
            profileView.schoolLabel.text = school
        }
        profileView.useridLabel.text = "\(user.followersCount ?? 0) followers"
        NetworkManager.shared.getAsynchImage(withURL: user.photoURL) { (image, error) in
            if image != nil {
                DispatchQueue.main.async {
                    self.profileView.profileImageView.image = image
                    self.setShadowForProfileImage()
                }
            }
        }
    }
    let schools = [ "ucsc": "University of California, Santa Cruz", "ucla": "University of California, Los Angeles", "gmail": "University of Gmail"]
     
    private func getSchoolFrom(email: String) -> String?{
        let schoolResults = schools.filter { (element) -> Bool in
            if email.contains(element.key){
                return true
            } else {
                return false
            }
        }
        guard let school = schoolResults.first else {return nil}
        return school.value
    }
    private func setShadowForProfileImage(){
        let shadowRect = self.profileView.profileImageViewContainer.layer.bounds
        self.profileView.profileImageViewContainer.layer.masksToBounds = false
        self.profileView.profileImageViewContainer.layer.shadowColor = UIColor.black.cgColor//Constants.Colors.mainYellow.cgColor
        self.profileView.profileImageViewContainer.layer.shadowOpacity = 0.2
        self.profileView.profileImageViewContainer.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.profileView.profileImageViewContainer.layer.shadowRadius = 10
        self.profileView.profileImageViewContainer.layer.cornerRadius = 50
        self.profileView.profileImageViewContainer.layer.shadowPath = UIBezierPath(roundedRect: shadowRect, cornerRadius: shadowRect.height / 2).cgPath
        self.profileView.profileImageViewContainer.layer.shouldRasterize = true
        self.profileView.profileImageViewContainer.layer.rasterizationScale = UIScreen.main.scale
    }
}













// MARK: - might not use this code at all!
//private func fetchUserPosts(){
//    guard let user = user else{return}
//    var query = NetworkManager.shared.db.posts.whereField(FirestoreFields.userInfoUserID.rawValue, isEqualTo: user.userID)
//    NetworkManager.shared.getDocumentsForQuery(query: query) { (posts: [Post]?, error) in
//        if error != nil{
//            print("Error loading posts for user \(String(describing: error?.localizedDescription))")
//        }else if posts != nil{
//            self.posts = posts!
//             //self.profileView?.tableViewAndCollectionView?.loungeTableView.reloadData()
//        }
//    }
//    //fetch missions
//    //print(user.userID)
//    query = NetworkManager.shared.db.missions.whereField(FirestoreFields.userInfoUserID.rawValue, isEqualTo: user.userID)
//    NetworkManager.shared.getDocumentsForQuery(query: query) { (missions: [Mission]?, error) in
//        if error != nil{
//            print("Error loading missions for user \(String(describing: error?.localizedDescription))")
//        }else if missions != nil{
//            self.missions = missions!
//            //self.profileView?.tableViewAndCollectionView?.bulletinBoardCollectionView.reloadData()
//        }
//    }
//}
//private func setupTableViews(){
//    //profileView?.tableViewAndCollectionView?.loungeTableView.delegate = self
//    //profileView?.tableViewAndCollectionView?.bulletinBoardCollectionView.delegate = self
//    //profileView?.tableViewAndCollectionView?.loungeTableView.dataSource = self
//    //profileView?.tableViewAndCollectionView?.bulletinBoardCollectionView.dataSource = self
//
//    //profileView?.tableViewAndCollectionView?.loungeTableView.rowHeight = UITableView.automaticDimension
//    //profileView?.tableViewAndCollectionView?.loungeTableView.estimatedRowHeight = 100
//
//    //profileView?.tableViewAndCollectionView?.loungeTableView.register(PostCellWithoutImage.self, forCellReuseIdentifier: PostCellWithoutImage.cellID)
//    //profileView?.tableViewAndCollectionView?.bulletinBoardCollectionView.register(BoardCell.self, forCellWithReuseIdentifier: BoardCell.cellID)
//}

//extension OtherProfileViewController: UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        posts.count
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        presentPostFor(indexPath: indexPath)
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCellWithoutImage.cellID, for: indexPath) as? PostCellWithoutImage else {return UITableViewCell()}
//        addData(toCell: cell, withIndex: indexPath.row)
//        cell.indexPath = indexPath
//        cell.delegate = self
//        cell.selectionStyle = .none
//        return cell
//    }
//    private func addData(toCell cell: PostCellWithoutImage, withIndex index: Int ){
//        NetworkManager.shared.getAsynchImage(withURL: posts[index].userInfo.photoURL) { (image, error) in
//            DispatchQueue.main.async {
//                cell.authorImageView.image = image
//            }
//        }
//        cell.postImageView.image = nil
//        cell.titleLabel.text =  posts[index].title
//        cell.messageLabel.text =  posts[index].text
//        cell.authorLabel.text =  posts[index].userInfo.name
//        cell.likesLabel.text =  String(posts[index].likes)
//        cell.commentsLabel.text =  String(posts[index].commentCount)
//        cell.stationButton.setTitle(posts[index].stationName, for: .normal)
//        let formatter = DateFormatter()
//        formatter.timeStyle = .short
//        let dateString = formatter.string(from: posts[index].date)
//        cell.dateLabel.text = "\(dateString)"
//        if posts[index].imageURL != nil {
//            cell.postImageView.isHidden = false
//            NetworkManager.shared.getAsynchImage(withURL: posts[index].imageURL) { (image, error) in
//                DispatchQueue.main.async {
//                    cell.postImageView.image = image
//                }
//            }
//        } else{
//            cell.postImageView.isHidden = true
//        }
//    }
//}

//extension OtherProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
//
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
//        cell.descriptionLabel.text = missions[indexPath.row].title
//        NetworkManager.shared.getAsynchImage(withURL: missions[indexPath.row].imageURL) { (image, error) in
//            if image != nil {
//                DispatchQueue.main.async {
//                    cell.boardImageView.image = image
//                }
//            }
//        }
//        return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: (self.view.frame.width/2) - 13, height: self.view.frame.width*0.6)
//    }
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 1.0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout
//                            collectionViewLayout: UICollectionViewLayout,
//                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 1.0
//    }
//}
//extension OtherProfileViewController: PostCellDidTapDelegate{
//    func didTapAuthorLabel(_ indexPath: IndexPath) {
//        presentAuthorFor(indexPath: indexPath)
//    }
//
//    func didTapStationButton(_ indexPath: IndexPath) {
//        presentStationFor(indexPath: indexPath)
//    }
//    func didTapLikeButton(_ indexPath: IndexPath) {
//
//    }
//    func didTapDislikeButton(_ indexPath: IndexPath) {
//
//    }
//    func didTapCommentsButton(_ indexPath: IndexPath) {
//        presentPostFor(indexPath: indexPath)
//    }
//
//    private func presentPostFor(indexPath: IndexPath){
////        let postvc = PostViewController(post: posts[indexPath.row])
////        postvc.hidesBottomBarWhenPushed = true
////        self.navigationController?.pushViewController(postvc, animated: true)
//    }
//    private func presentStationFor(indexPath: IndexPath){
//        NetworkManager.shared.getDocumentForID(collection: .stations ,uid: posts[indexPath.row].stationID) { (document: Station?, error) in
//            if error != nil {
//                print("error receiving station")
//            }else if document != nil {
//                let vc = StationViewController()
//                vc.station = document
//                vc.modalPresentationStyle = .fullScreen
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
//        }
//    }
//    private func presentAuthorFor(indexPath: IndexPath){
//        let vc = OtherProfileViewController(user: posts[indexPath.row].userInfo)
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//}


