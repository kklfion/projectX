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

class FeedCollectionViewController: UICollectionViewController{
    ///Loading footer reuse identifier
    let footerViewReuseIdentifier = "footerViewReuseIdentifier"
    ///Post ceell reuse identifiers
    let cellReuseIdentifier = "cellReuseIdentifier"
    
    private var dataSource: UICollectionViewDiffableDataSource<FeedSection, Post>!
    
    ///delegated used to send scrolling data to the parent view (station)
    var didScrollFeedDelegate: DidScrollFeedDelegate?
    
    ///used to perform data fetching
    private var postPaginator: PostPaginator!
    
    ///to keep reference to the footerView to start/stop animation
    var loadingFooterView: LoadingFooterView?
    
    ///posts displayed in the feed
    private var posts = [Post]()
    
    ///likes for the posts in the feed
    private var likesDictionary = [Post: Like]()
    
    ///provided by
    private var userID: String?
    
    init(){
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - FeedController Setup functions
extension FeedCollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupDiffableDatasource()
        setupRefreshControl()
    }
    ///parent view controller must call this function to setup appropriate feed.
    func setupFeed(feedType: FeedType, paginatorId: String? = nil, userID: String? = nil){
        switch feedType {
        case .generalFeed:
            self.postPaginator = PostPaginator()
        case .stationFeed:
            self.postPaginator = PostPaginator(stationID: paginatorId ?? "")
        case .userHistoryFeed:
            self.postPaginator = PostPaginator(userID: paginatorId ?? "")
        }
        self.userID = userID
        self.resetCollectionViewIfNeeded()
        self.fetchDataWithPagination()
    }
    private func resetCollectionViewIfNeeded(){
        //delete old data
        var initialSnapshot = dataSource.snapshot()
        initialSnapshot.deleteAllItems()
        posts.removeAll()
        //likes.removeAll()
        likesDictionary.removeAll()
        self.dataSource.apply(initialSnapshot, animatingDifferences: false)
        //reset pagination
        postPaginator?.resetPaginator()
    }
}
//MARK: - FeedController enums
extension FeedCollectionViewController {
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellReuseIdentifier, for: indexPath) as! PostCollectionViewCell
            cell.postImageView.image = nil
            cell.authorImageView.image = nil
            self.addData(toCell: cell, withPost: self.posts[indexPath.item])
            cell.delegate = self
            cell.indexPath = indexPath
            return cell
        })
        //configure datasource for footer view
        dataSource.supplementaryViewProvider = .some({ (collectionView, kind, indexPath) -> UICollectionReusableView? in
            if kind == UICollectionView.elementKindSectionFooter {
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.footerViewReuseIdentifier, for: indexPath) as! LoadingFooterView
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
                                               heightDimension: .absolute(140))
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
        presentPostFor(indexPath: indexPath, likesDictionary[posts[indexPath.row]])
    }
    //TODO: move to cell
    private func addData(toCell cell: PostCollectionViewCell, withPost post: Post ){
        cell.titleLabel.text =  post.title
        cell.authorLabel.text =  post.userInfo.name
        cell.likesLabel.text =  String(post.likes)
        cell.commentsLabel.text =  String(post.commentCount)
        cell.stationButton.setTitle(post.stationName, for: .normal)
        let dateString = post.date.diff()
        cell.dateLabel.text = "\(dateString)"
        if !post.isAnonymous{
            cell.authorLabel.text =  post.userInfo.name
            NetworkManager.shared.getAsynchImage(withURL: post.userInfo.photoURL) { (image, error) in
                DispatchQueue.main.async {
                    cell.authorImageView.image = image
                }
            }
            cell.authorLabel.isUserInteractionEnabled = true
            cell.authorImageView.isUserInteractionEnabled = true
        } else{
            cell.setAnonymousUser()
        }
        if post.imageURL != nil {
            NetworkManager.shared.getAsynchImage(withURL: post.imageURL) { (image, error) in
                DispatchQueue.main.async {
                    cell.setPostImage(image: image)
                }
            }
        } else{
            cell.setDefaultPostImage()
        }
        
        if likesDictionary[post] != nil {
            cell.isLiked = true
        }else{
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
    func fetchDataWithPagination(){
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
            NetworkManager.shared.getDocumentsForQuery(query: query) { (likedPosts: [Like]?, error) in
                if error != nil {
                    print("error loading liked post", error!)
                }else if likedPosts != nil {
                    self.likesDictionary[doc] = likedPosts![0]
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
        var snapshot = NSDiffableDataSourceSnapshot<FeedSection, Post>()
        snapshot.appendSections([.main])
        snapshot.appendItems(self.posts, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
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
        presentPostFor(indexPath: indexPath, likesDictionary[posts[indexPath.row]])
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
    private func presentPostFor(indexPath: IndexPath,_ like: Like?){
        let postvc = PostViewController(post: posts[indexPath.row], like: like, indexPath: indexPath)
        postvc.hidesBottomBarWhenPushed = true
        postvc.updatePostDelegate = self
        self.navigationController?.pushViewController(postvc, animated: true)
    }
    private func presentStationFor(indexPath: IndexPath){
        NetworkManager.shared.getDocumentForID(collection: .stations, uid: posts[indexPath.row].stationID) { (document: Station?, error) in
            if error != nil {
                print("error receiving station")
            }else if let doc = document {
                var vc: BaseStationViewController
                switch doc.stationType {
                case .parentStation:
                    vc = ParentStationViewController(station: doc)
                case .subStation:
                    vc = SubstationViewController(station: doc)
                case .station:
                    vc = RegularStationViewController(station: doc)
                }
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
        var document = Like(userID: userID, postID: postID)
        NetworkManager.shared.writeDocumentReturnReference(collectionType: .likedPosts, document: document  ) { (ref, error) in
            if let err = error{
                print("Error creating like \(err)")
            } else { //need to increment likes in the post
                NetworkManager.shared.incrementDocumentValue(collectionType: .posts,
                                                             documentID: postID,
                                                             value: Double(1),
                                                             field: .likes)
                document.id = ref
                self.likesDictionary[self.posts[indexPath.item]] = document
            }
        }
    }
    private func deleteLikeFromFirestore(with indexPath: IndexPath){
        guard let likedPost = likesDictionary[posts[indexPath.item]] else {return}
        guard let docID = likedPost.id else {return}
        guard let postID = posts[indexPath.item].id else {return}
        likesDictionary.removeValue(forKey: self.posts[indexPath.item])
        NetworkManager.shared.deleteDocumentsWith(collectionType: .likedPosts,
                                                  documentID: docID) { (error) in
            if error != nil{
                print("error disliking", error!)
            }else{
                NetworkManager.shared.incrementDocumentValue(collectionType: .posts,
                                                             documentID: postID,
                                                             value: Double(-1),
                                                             field: .likes)
            }
        }
    }
}
extension FeedCollectionViewController: DidUpdatePostAfterDissmissingDelegate {
    //reload cell and reload data for that cell
    func updatePostModelInTheFeed(_ indexPath: IndexPath, post: Post, like: Like?, status: LikeStatus) {
        //1.get id
        guard let selectedPost = dataSource.itemIdentifier(for: indexPath) else {return}
        guard  let cell = collectionView.cellForItem(at: indexPath) as? PostCollectionViewCell else {return}
        //2.updateData (likes & post & database)
        posts[indexPath.item].commentCount = post.commentCount
        if status == .add || status == .delete{
            didTapLikeButton(indexPath, cell)
        }
        //3.trigger reload
        var snapshot = dataSource.snapshot()
        snapshot.reloadItems([selectedPost])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    
}

