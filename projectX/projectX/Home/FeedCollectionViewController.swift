//
//  FeedCollectionViewController.swift
//  projectX
//
//  Created by Radomyr Bezghin on 1/12/21.
//  Copyright © 2021 Radomyr Bezghin. All rights reserved.
//

import UIKit
import FirebaseAuth

///sends scrollView updates to the parent viewcontroller
protocol DidScrollFeedDelegate {
    func didScrollFeed(_ scrollView: UIScrollView)
}
///The Only one section in collectionView
enum FeedSection {
    ///Section that displays posts
    case main
}
///Feed types to init feed
enum FeedType {
    case userHistoryFeed
    case generalFeed
    case stationFeed
}
///Loading footer reuse identifier
let footerViewReuseIdentifier = "footerViewReuseIdentifier"
///Post ceell reuse identifiers
let cellReuseIdentifier = "cellReuseIdentifier"

class FeedCollectionViewController: UICollectionViewController{
    
    private var dataSource: UICollectionViewDiffableDataSource<FeedSection, Post>!
    
    ///delegated used to send scrolling data to the parent view (station)
    var didScrollFeedDelegate: DidScrollFeedDelegate?
    
    ///used to perform data fetching
    private var postPaginator: PostPaginator?
    
    ///to keep reference to the footerView to start/stop animation
    var loadingFooterView: LoadingFooterView?
    
    ///posts displayed in the feed
    private var posts = [Post]()
    
    ///likes for the posts in the feed
    private var likes = [LikedPost]()
    
    private var userID: String?
    
    init(){
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupDiffableDatasource()
        setupRefreshControl()
        
        if userID != nil {
            self.fetchDataWithPagination()
        }
        
        UserManager.shared().didResolveUserState = { user in
            self.userID = user?.userID
            self.resetCollectionViewIfNeeded()
            self.fetchDataWithPagination()
        }
    }
    private func resetCollectionViewIfNeeded(){
        //delete old data
        var initialSnapshot = dataSource.snapshot()
        initialSnapshot.deleteAllItems()
        posts.removeAll()
        likes.removeAll()
        self.dataSource.apply(initialSnapshot, animatingDifferences: false)
        //reset pagination
        postPaginator?.resetPaginator()
    }

    ///parent view controller must call this function to setup appropriate feed. Is called BEFORE viewDidLoad
    func setupFeed(feedType: FeedType, id: String? = nil){
        switch feedType {
        case .generalFeed:
            self.postPaginator = PostPaginator()
        case .stationFeed:
            self.postPaginator = PostPaginator(stationID: id ?? "")
        case .userHistoryFeed:
            self.postPaginator = PostPaginator(userID: id ?? "")
        }
    }
}
//MARK: - CollectionView setup
extension FeedCollectionViewController{
    private func setupCollectionView(){
        collectionView.backgroundColor = .white
        self.collectionView?.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        self.collectionView.register(LoadingFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerViewReuseIdentifier)
    }
    private func setupDiffableDatasource(){
        //configure layout for cell and footer
        collectionView.collectionViewLayout = createLayout()
        //configure datasource for cells
        dataSource = .init(collectionView: collectionView, cellProvider: { (collectionView, indexPath, post) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! PostCollectionViewCell
            self.addData(toCell: cell, withPost: post)
            cell.delegate = self
            cell.indexPath = indexPath
            return cell
        })
        //configure datasource for footer view
        dataSource.supplementaryViewProvider = .some({ (collectionView, kind, indexPath) -> UICollectionReusableView? in
            if kind == UICollectionView.elementKindSectionFooter {
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerViewReuseIdentifier, for: indexPath) as! LoadingFooterView
                self.loadingFooterView = view
                return view
            }else {
                return nil
            }
        })
        collectionView.dataSource = dataSource
    }
    //TODO: add estimatedHeight to make cells dynamically sized
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        
        let kind = UICollectionView.elementKindSectionFooter
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                    heightDimension: .absolute(80)),
                  elementKind: kind, alignment: .bottom)
        ]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentPostFor(indexPath: indexPath)
    }
    //TODO: move to cell
    private func addData(toCell cell: PostCollectionViewCell, withPost post: Post ){
        cell.postImageView.image = nil
        cell.titleLabel.text =  post.title
        cell.messageLabel.text =  post.text
        cell.authorLabel.text =  post.userInfo.name
        cell.likesLabel.text =  String(post.likes)
        cell.commentsLabel.text =  String(post.commentCount)
        cell.stationButton.setTitle(post.stationName, for: .normal)
        let dateString = post.date.diff()
        cell.dateLabel.text = "\(dateString)"
        NetworkManager.shared.getAsynchImage(withURL: post.userInfo.photoURL) { (image, error) in
            DispatchQueue.main.async {
                cell.authorImageView.image = image
            }
        }
        if post.imageURL != nil {
            cell.postImageView.isHidden = false
            NetworkManager.shared.getAsynchImage(withURL: post.imageURL) { (image, error) in
                DispatchQueue.main.async {
                    cell.postImageView.image = image
                }
            }
        } else{
            cell.postImageView.isHidden = true
        }
        
        if likes.contains(where: { $0.postID == post.id }) {
            cell.isLiked = true
        } else{
            cell.isLiked = false
        }
    }
    func setupRefreshControl () {
        // Add the refresh control to your UIScrollView object.
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action:
                                          #selector(handleRefreshControl),
                                          for: .valueChanged)
    }
    @objc func handleRefreshControl() {
        resetCollectionViewIfNeeded()
        fetchDataWithPagination()
    }
}
//MARK: - Post fetching & applying & scrollViewDidScroll
extension FeedCollectionViewController {
    ///Initial fetch should be done with pagination false, all other calls with pagination true
    private func fetchDataWithPagination(){
        postPaginator?.queryPostWith() { [weak self] result in
            switch result {
                case .success(let data):
                    self?.posts.append(contentsOf: data)
                    DispatchQueue.global(qos: .userInitiated).async { //global queue to prevent app from freezing while waiting
                        self?.updatePostsAndLikesWith(data: data)
                    }
                case .failure(let error):
                    print("FeedVC Failed loading data ", error)
            }
        }
    }
    ///when users scrolls to the bottom of the loaded data, more data is fetched
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScrollFeedDelegate?.didScrollFeed(scrollView)
        //FIXME: - figureout when its okay to call fetching ><
        let position = scrollView.contentOffset.y
        if position < 0 {return}
        if position > (collectionView.contentSize.height-100-scrollView.frame.size.height) && collectionView.contentSize.height > 0{
            guard let paginator = postPaginator else {return}
            if (paginator.isFetching) {return}//we fetching data, no need to fetch more
            self.loadingFooterView?.startAnimating() //animation stops when data is done fetching
            fetchDataWithPagination()
        }
    }
    ///afterter new posts were fetched, this function fetches likes for the posts and updates local posts, likes models and reloads collectionView
    private func updatePostsAndLikesWith(data: [Post]){
        let group = DispatchGroup()
        for doc in data {
            group.enter()
            guard let  id = doc.id else {continue}
            let query = NetworkManager.shared.db.likedPosts
                .whereField(FirestoreFields.postID.rawValue, isEqualTo: id)
                .whereField(FirestoreFields.userID.rawValue, isEqualTo: userID ?? "")
            NetworkManager.shared.getDocumentsForQuery(query: query) { (likedPosts: [LikedPost]?, error) in
                if error != nil {
                    print("error loading liked post", error!)
                }else if likedPosts != nil {
                    self.likes.append(contentsOf: likedPosts!)
                }
                group.leave()
            }
        }
        group.wait()
        DispatchQueue.main.async {
            self.applyFetchedDataOnCollectionView(data: data)
        }
    }
    private func applyFetchedDataOnCollectionView(data: [Post]){
        self.loadingFooterView?.stopAnimating()
        self.collectionView.refreshControl?.endRefreshing()
        var initialSnapshot = NSDiffableDataSourceSnapshot<FeedSection, Post>()
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(self.posts, toSection: .main)
        self.dataSource.apply(initialSnapshot, animatingDifferences: true)
    }
}
//MARK: - PostCollectionViewCellDidTapDelegate
extension FeedCollectionViewController: PostCollectionViewCellDidTapDelegate{
    func didTapAuthorLabel(_ indexPath: IndexPath) {
        presentAuthorFor(indexPath: indexPath)
    }

    func didTapStationButton(_ indexPath: IndexPath) {
        presentStationFor(indexPath: indexPath)
    }
    func didTapLikeButton(_ indexPath: IndexPath, _ cell: PostCollectionViewCell) {
        cell.isLiked.toggle()
        if cell.isLiked{
            //1. change UI
            cell.changeCellToLiked()
            //2. change locally
            posts[indexPath.item].likes += 1
            //3. change in the DB
            writeLikeToTheFirestore(with: indexPath)
        } else{
            //1. change UI
            cell.changeCellToDisliked()
            //2. change locally
            posts[indexPath.item].likes -= 1
            //3. change in the DB
            deleteLikeFromFirestore(with: indexPath)
        }
    }
    func didTapCommentsButton(_ indexPath: IndexPath) {
        presentPostFor(indexPath: indexPath)
    }
}
//MARK: - Navigation
extension FeedCollectionViewController{
    ///when app is loaded and user isnt signed in, login screen is presented
    private func presentLoginIfNeeded(){
        if Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let navvc = UINavigationController(rootViewController: vc)
            navvc.modalPresentationStyle = .fullScreen
            self.tabBarController?.present(navvc, animated: true)
        }
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
//MARK: - Networking calls like/dislike
extension FeedCollectionViewController {
    private func writeLikeToTheFirestore(with indexPath: IndexPath) {
        guard  let userID = userID else {return}
        guard let postID = posts[indexPath.item].id else {return}
        var document = LikedPost(userID: userID, postID: postID)
        NetworkManager.shared.writeDocumentReturnReference(collectionType: .likedPosts, document: document  ) { (ref, error) in
            if let err = error{
                print("Error creating like \(err)")
            } else { //need to increment likes in the post
                NetworkManager.shared.incrementDocumentValue(collectionType: .posts,
                                                             documentID: postID,
                                                             value: Double(1),
                                                             field: .likes)
                document.id = ref
                self.likes.append(document)
            }
        }
    }
    private func deleteLikeFromFirestore(with indexPath: IndexPath){
        let likedPosts = likes.filter { $0.postID == posts[indexPath.item].id }
        guard let likedPost = likedPosts.first else {return}
        guard let docID = likedPost.id else {return}
        guard let postID = posts[indexPath.item].id else {return}
        NetworkManager.shared.deleteDocumentsWith(collectionType: .likedPosts,
                                                  documentID: docID) { (error) in
            if error != nil{
                print("error disliking", error!)
            }else{
                NetworkManager.shared.incrementDocumentValue(collectionType: .posts,
                                                             documentID: postID,
                                                             value: Double(-1),
                                                             field: .likes)
                guard let indexToRemove = self.likes.firstIndex(where: { $0.id == docID }) else {return}
                self.likes.remove(at: indexToRemove)
                
            }
        }
    }
}

