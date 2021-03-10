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
class OtherProfileViewController: UIViewController, DidScrollFeedDelegate, SlidableTopViewProtocol {
    
    lazy var profileHeight = view.frame.height * 0.4
     
    ///height of the status bar, used in calculations for the sliding up view
    var headerHeight: CGFloat?
    
    var headerTopConstraint: NSLayoutConstraint!
    
    func didScrollFeed(_ scrollView: UIScrollView) {
        adjustHeaderPosition(scrollView, navigationController, navigationItem: navigationItem, user?.name, "#FFCC00" )
    }
    ///user displayed by the controller
    var user: User?
    
    var userImage: UIImage?
    
    ///one of two types of the profile
    var profileType: ProfileType
    
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
    
    ///to initialize your profile
    init() {
        self.profileType = .personalProfile
        super.init(nibName: nil, bundle: nil)
    }
    ///initialize profileviewcontroller with user data (to display other user profile)
    init(user: User, userImage: UIImage?){
        self.user = user
        self.userImage = userImage
        self.profileType = .otherProfile
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationToTransparent()
        extendedLayoutIncludesOpaqueBars = true
        view.backgroundColor = Constants.Colors.mainBackground
        navigationItem.largeTitleDisplayMode = .never
        setupProfileView()
        setupFeedVCs()
        switch profileType{
        case .otherProfile:
            updateProfileInformation()
            guard let userid = user?.userID else {return}
            feedCollectionViewController.setupFeed(feedType: .userHistoryFeed(userid),
                                                   userID: user?.userID)
            
            checkIfUserIsFollowed()
        case .personalProfile:
            setUserAndSubscribeToUpdates()
            profileView.followButton.isHidden = true
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !headerHeightWasSet() && feedSegmentedControl.leftButton.frame.height != 0 && profileView.frame.height != 0 {
            let headerHeight = profileView.frame.height
            let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0
            let navBarHeight = self.navigationController?.navigationBar.frame.height ?? 0.0
            let safeAreaInset = statusBarHeight + navBarHeight
            setupHeaderHeight(header: headerHeight, safeArea: safeAreaInset)
        }
    }
    private func checkIfUserIsFollowed(){
        guard let userToFollowID = user?.userID else {return}
        if UserManager.shared().isUserFollowed(userID: userToFollowID) != nil {
            self.profileView.setFollowButtonToFollowed()
        } else {
            self.profileView.setFollowButtonToNotFollowed()
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
            guard let userid = user.id else {return}
            feedCollectionViewController.setupFeed(feedType: .userHistoryFeed(userid), userID: user.id)
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
                guard let userid = user?.id else {return}
                self.feedCollectionViewController.setupFeed(feedType: .userHistoryFeed(userid), userID: user?.id)
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
        headerTopConstraint = profileView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
        headerTopConstraint.isActive = true
        profileView.followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        
        view.addSubview(feedSegmentedControl)
        feedSegmentedControl.addAnchors(top: profileView.bottomAnchor,
                                        leading: view.leadingAnchor,
                                        bottom: view.bottomAnchor,
                                        trailing: view.trailingAnchor,
                                        padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
    private func setupFeedVCs(){
        let vc = UIViewController() //instead of the missions vc
        vc.view.backgroundColor  = Constants.Colors.mainBackground
        feedCollectionViewController = FeedCollectionViewController()
        self.addChild(feedCollectionViewController)
        feedCollectionViewController.didScrollFeedDelegate = self
        feedSegmentedControl.stackView.addArrangedSubview(feedCollectionViewController.view)
        feedSegmentedControl.stackView.addArrangedSubview(vc.view)
    }
    @objc func didTapFollowButton(){
        guard let otherUserID = user?.userID else {return}
        //need to fetch whether user was is followed
        //if followed and tapped - unfollow
        if UserManager.shared().isUserFollowed(userID: otherUserID) != nil { //already followed / able to fetch the follow
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
                        self.profileView.changeFollowerCount(by: (self.user?.followersCount ?? 1) - 1 )
                        UserManager.shared().removeFollowedUser(userID: userToFollowID)
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
        var doc = Follower(userID: personalID, followingUserWithID: userToFollowID)
        NetworkManager.shared.writeDocumentReturnReference(collectionType: .followers, document: doc) { (referenceID, error) in
            if error != nil {
                print(error?.localizedDescription ?? "error creating follower")
            }else if (referenceID != nil){
                doc.id = referenceID
                self.profileView.setFollowButtonToFollowed()
                self.profileView.changeFollowerCount(by: (self.user?.followersCount ?? 1) + 1 )
                UserManager.shared().addFollowedUser(followedUser: doc)
                NetworkManager.shared.incrementDocumentValue(collectionType: .users,
                                                             documentID: userToFollowID,
                                                             value: Double(1),
                                                             field: .followersCount)
            }
        }
    }
    private func updateProfileInformation(){
        guard let user = user else{return}
        profileView.usernameLabel.text = user.name
        profileView.changeFollowerCount(by: user.followersCount)
        if let school = getSchoolFrom(email: user.email){
            profileView.schoolLabel.text = school
        }
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
        self.profileView.profileImageViewContainer.layer.shadowColor = Constants.Colors.shadow.cgColor//Constants.Colors.mainYellow.cgColor
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


