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

class HomeTableVC: UICollectionViewController, UISearchBarDelegate{
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    ///posts displayed in the feed
    private var posts = [Post]()
    
    ///likes for the posts in the feed
    private var likes = [LikedPost]()

    init(){
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoginScreenIfNeeded()
        setupCollectionView()
        setupNavigationBar()
        DispatchQueue.global(qos: .userInitiated).async {
            self.getData()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    private func setupNavigationBar(){
        self.navigationItem.title = "Home"
        navigationItem.searchController = searchController
        //navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.shadowColor = .none
        navBarAppearance.backgroundColor = Constants.Colors.mainYellow
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
//        navigationController?.navigationBar.layer.cornerRadius = 25
//        navigationController?.navigationBar.clipsToBounds = true
    }
    private func setupCollectionView(){
        collectionView.backgroundColor = .white
        self.collectionView?.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.cellID)
    }
    private func getData(){
        
        var documentsPosts = [Post]()
        
        let group = DispatchGroup()
        
        group.enter()
        let query = NetworkManager.shared.db.posts
        NetworkManager.shared.getDocumentsForQuery(query: query) { (posts: [Post]? , error) in
            if error != nil{
                print("Error loading posts for home \(String(describing: error?.localizedDescription))")
            }else if posts != nil{
                documentsPosts = posts!
            }
            group.leave()
        }
        
        group.wait()
        for doc in documentsPosts {
            group.enter()
            guard let id = doc.id else {continue}
            //FIXME: use current user ID instead of the static one !!
            let userid = "59qIdPL8uAfltJryIrAWfQNFcuN2"//UserManager.shared().user?.id else {continue}
            let query = NetworkManager.shared.db.likedPosts
                .whereField(FirestoreFields.postID.rawValue, isEqualTo: id)
                .whereField(FirestoreFields.userID.rawValue, isEqualTo: userid)
            NetworkManager.shared.getDocumentsForQuery(query: query) { (likedPosts: [LikedPost]?, error) in
                if error != nil {
                    print("error loading liked post", error!)
                }else if likedPosts != nil {
                    self.likes.append(contentsOf: likedPosts!)
                    print("received a like")
                }
                group.leave()
            }
        }
        group.wait()
        
        print("restart collection")
        self.posts.append(contentsOf: documentsPosts)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
        
        //1. get posts
        
        //2. get likes
        
        //3. reload tableview
        
    }
    private func showLoginScreenIfNeeded(){
        if Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let navvc = UINavigationController(rootViewController: vc)
            navvc.modalPresentationStyle = .fullScreen
            self.tabBarController?.present(navvc, animated: true)
        }
    }
}
extension HomeTableVC: SideBarStationSelectionDelegate{
    func didTapSidebar(station: Station) {
        switch station.stationType {
        case .parentStation:
            let vc = ParentStationViewController()
            vc.station = station
            navigationController?.pushViewController(vc, animated: true)
        default:
            let vc = StationViewController()
            vc.station = station
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
// MARK: UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
extension HomeTableVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.frame.width, height: 200)
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentPostFor(indexPath: indexPath)
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.cellID, for: indexPath) as? PostCollectionViewCell else {return UICollectionViewCell()}
        addData(toCell: cell, withIndex: indexPath.row)
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }

    private func addData(toCell cell: PostCollectionViewCell, withIndex index: Int ){
        //cell.isLiked = false
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
        NetworkManager.shared.getAsynchImage(withURL: posts[index].userInfo.photoURL) { (image, error) in
            DispatchQueue.main.async {
                cell.authorImageView.image = image
            }
        }
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
        
        if likes.contains(where: { $0.postID == posts[index].id }) {
            cell.isLiked = true
        }
    }
}
extension HomeTableVC: PostCollectionViewCellDidTapDelegate{
    func didTapAuthorLabel(_ indexPath: IndexPath) {
        presentAuthorFor(indexPath: indexPath)
    }

    func didTapStationButton(_ indexPath: IndexPath) {
        presentStationFor(indexPath: indexPath)
    }
    func didTapLikeButton(_ indexPath: IndexPath, _ cell: PostCollectionViewCell) {
        //1. change UI
        cell.isLiked.toggle()
        if cell.isLiked{
            //2. change locally
            posts[indexPath.item].likes += 1
            //3. change in the DB
            writeLikeToTheFirestore(with: indexPath)
        } else{
            //2. change locally
            posts[indexPath.item].likes -= 1
            //3. change in the DB
            deleteLikeFromFirestore(with: indexPath)
        }
    }
    private func writeLikeToTheFirestore(with indexPath: IndexPath) {
        guard  let userID = UserManager.shared().user?.userID else {return}
        guard let postID = posts[indexPath.item].id else {return}
        let document = LikedPost(userID: userID, postID: postID)
        NetworkManager.shared.writeDocumentsWith(collectionType: .likedPosts, documents: [document]) { (error) in
            if let err = error{
                print("Error creating like \(err)")
            } else{ //need to increment likes in the post
                NetworkManager.shared.incrementDocumentValue(collectionType: .posts,
                                                             documentID: postID,
                                                             value: Double(1),
                                                             field: .likes)
                print("like written!)")
            }
        }
    }
    private func deleteLikeFromFirestore(with indexPath: IndexPath){
        let likedPost = LikedPost(id: "", userID: "", postID: "", date: Date())
        guard  let docID = likedPost.id else {return}
        NetworkManager.shared.deleteDocumentsWith(collectionType: .likedPosts,
                                                  documentID: docID) { (error) in
            if error != nil{
                print("error disliking", error!)
            }else{
                print("success disliking")
            }
        }
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
        NetworkManager.shared.getDocumentForID(collection: .stations, uid: posts[indexPath.row].stationID) { (document: Station?, error) in
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
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
