//
//  OtherProfileViewController.swift
//  projectX
//
//  Created by Radomyr Bezghin on 10/22/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit
import FirebaseAuth

class OtherProfileViewController: UIViewController {
    
    ///user displayed by the controller
    var user: User
    
    ///posts that were created by user
    private var posts = [Post]()
    
    ///missions accepted by the user ? or created?
    private var missions = [Mission]()
    
    ///custom view
    private var profileView: ProfileView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = false
    }
    ///initialize profileviewcontroller with user data (to display other user profile)
    init(user: User){
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    ///user to display current user
    init(){
        //must wait for usermanager to complete and update self
        user = User(email: "1", uid: "1")
        super.init(nibName: nil, bundle: nil)
        let user = Auth.auth().currentUser
        guard let id = user?.uid else {return}
        NetworkManager.shared.getDataForUser(id) { [weak self] (user, error) in
            if error != nil {
                print(error)
            }else if user != nil {
                self?.user = user!
                self?.updateProfileInformation()
            }
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        extendedLayoutIncludesOpaqueBars = true
        view.backgroundColor = .white
        setupView()
        setupTableViews()
        updateProfileInformation()
    }
    private func setupView(){
        profileView = ProfileView(frame: self.view.frame)
        guard let profileView = profileView else {return}
        view.addSubview(profileView)
        profileView.addAnchors(top: view.topAnchor,
                               leading: view.leadingAnchor,
                               bottom: view.bottomAnchor,
                                trailing: view.trailingAnchor)
        //setupNavBar()
    }
    private func setupTableViews(){
        profileView?.tableViewAndCollectionView?.loungeTableView.delegate = self
        profileView?.tableViewAndCollectionView?.bulletinBoardCollectionView.delegate = self
        profileView?.tableViewAndCollectionView?.loungeTableView.dataSource = self
        profileView?.tableViewAndCollectionView?.bulletinBoardCollectionView.dataSource = self
        
        profileView?.tableViewAndCollectionView?.loungeTableView.rowHeight = UITableView.automaticDimension
        profileView?.tableViewAndCollectionView?.loungeTableView.estimatedRowHeight = 100
        
        profileView?.tableViewAndCollectionView?.loungeTableView.register(PostCellWithoutImage.self, forCellReuseIdentifier: PostCellWithoutImage.cellID)
        profileView?.tableViewAndCollectionView?.bulletinBoardCollectionView.register(BoardCell.self, forCellWithReuseIdentifier: BoardCell.cellID)
    }
    private func updateProfileInformation(){
        //guard let user = user else{return}
        NetworkManager.shared.getAsynchImage(withURL: user.photoURL) { (image, error) in
            if image != nil {
                DispatchQueue.main.async {
                    guard self.profileView?.profileImageViewContainer != nil else {return}
                    self.profileView?.profileImageView.image = image
                    if let shadowRect = self.profileView?.profileImageViewContainer.layer.bounds
                    {
                        self.profileView?.profileImageViewContainer.layer.masksToBounds = false
                        self.profileView?.profileImageViewContainer.layer.shadowColor = UIColor.black.cgColor//Constants.Colors.mainYellow.cgColor
                        self.profileView?.profileImageViewContainer.layer.shadowOpacity = 0.2
                        self.profileView?.profileImageViewContainer.layer.shadowOffset = CGSize(width: -1, height: 1)
                        self.profileView?.profileImageViewContainer.layer.shadowRadius = 10
                        self.profileView?.profileImageViewContainer.layer.cornerRadius = 50
                        self.profileView?.profileImageViewContainer.layer.shadowPath = UIBezierPath(roundedRect: shadowRect, cornerRadius: shadowRect.height / 2).cgPath
                        //self.profileView?.profileImageViewContainer.layer.shadowPath = UIBezierPath(rect: (self.profileView?.profileImageViewContainer.layer.bounds)!).cgPath
                        self.profileView?.profileImageViewContainer.layer.shouldRasterize = true
                        self.profileView?.profileImageViewContainer.layer.rasterizationScale = UIScreen.main.scale
                    }

                }
            }
        }
        profileView?.usernameLabel.text = user.name
        profileView?.useridLabel.attributedText = "@rad48 w/ 54 followers".withBoldText(text: "54")
        profileView?.schoolLabel.text = "University of California, Santa Cruz"
        //fetch posts
        //wtf is this id "4UYdlUuclzgQb5cbCq6F"
        var query = NetworkManager.shared.db.posts.whereField(FirestoreFields.userInfoUserID.rawValue, isEqualTo: user.userID)
        NetworkManager.shared.getDocumentsForQuery(query: query) { (posts: [Post]?, error) in
            if error != nil{
                print("Error loading posts for user \(String(describing: error?.localizedDescription))")
            }else if posts != nil{
                self.posts = posts!
                self.profileView?.tableViewAndCollectionView?.loungeTableView.reloadData()
            }
        }
        //fetch missions
        //print(user.userID)
        query = NetworkManager.shared.db.missions.whereField(FirestoreFields.userInfoUserID.rawValue, isEqualTo: user.userID)
        NetworkManager.shared.getDocumentsForQuery(query: query) { (missions: [Mission]?, error) in
            if error != nil{
                print("Error loading missions for user \(String(describing: error?.localizedDescription))")
            }else if missions != nil{
                self.missions = missions!
                self.profileView?.tableViewAndCollectionView?.bulletinBoardCollectionView.reloadData()
            }
        }
    }
}
extension OtherProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentPostFor(indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCellWithoutImage.cellID, for: indexPath) as? PostCellWithoutImage else {return UITableViewCell()}
        addData(toCell: cell, withIndex: indexPath.row)
        cell.indexPath = indexPath
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    private func addData(toCell cell: PostCellWithoutImage, withIndex index: Int ){
        cell.postImageView.image = nil
        cell.titleLabel.text =  posts[index].title
        cell.messageLabel.text =  posts[index].text
        cell.authorLabel.text =  posts[index].userInfo.name
        cell.likesLabel.text =  String(posts[index].likes)
        cell.commentsLabel.text =  String(posts[index].commentCount)
        cell.stationButton.setTitle(posts[index].stationName, for: .normal)
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let dateString = formatter.string(from: posts[index].date)
        cell.dateLabel.text = "\(dateString)"
        if posts[index].imageURL != nil {
            cell.postImageView.isHidden = false
            NetworkManager.shared.getAsynchImage(withURL: posts[index].imageURL) { (image, error) in
                DispatchQueue.main.async {
                    cell.postImageView.image = image
                }
            }
        } else{
            cell.postImageView.isHidden = true
        }
    }
}
extension OtherProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return missions.count / 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tryCell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardCell.cellID, for: indexPath) as? BoardCell
        guard let cell = tryCell else {
            return UICollectionViewCell()
        }
        
        cell.descriptionLabel.text = missions[indexPath.row].title
        NetworkManager.shared.getAsynchImage(withURL: missions[indexPath.row].imageURL) { (image, error) in
            if image != nil {
                DispatchQueue.main.async {
                    cell.boardImageView.image = image
                }
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (self.view.frame.width/2) - 13, height: self.view.frame.width*0.6)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
                            collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}
extension OtherProfileViewController: PostCellDidTapDelegate{
    func didTapAuthorLabel(_ indexPath: IndexPath) {
        presentAuthorFor(indexPath: indexPath)
    }

    func didTapStationButton(_ indexPath: IndexPath) {
        presentStationFor(indexPath: indexPath)
    }
    func didTapLikeButton(_ indexPath: IndexPath) {

    }
    func didTapDislikeButton(_ indexPath: IndexPath) {

    }
    func didTapCommentsButton(_ indexPath: IndexPath) {
        presentPostFor(indexPath: indexPath)
    }
    
    private func presentPostFor(indexPath: IndexPath){
        let postvc = PostViewController(post: posts[indexPath.row])
        postvc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(postvc, animated: true)
    }
    private func presentStationFor(indexPath: IndexPath){
        NetworkManager.shared.getDocumentForID(collection: .stations ,uid: posts[indexPath.row].stationID) { (document: Station?, error) in
            if error != nil {
                print("error receiving station")
            }else if document != nil {
                let vc = StationViewController()
                vc.station = document
                vc.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    private func presentAuthorFor(indexPath: IndexPath){
        let vc = OtherProfileViewController(user: posts[indexPath.row].userInfo)
        //vc.user = posts[indexPath.row].userInfo
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


