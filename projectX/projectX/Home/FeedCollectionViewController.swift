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
    enum FeedSection {
        ///Section that displays posts
        case main
    }
    ///Loading footer reuse identifier
    let footerViewReuseIdentifier = "footerViewReuseIdentifier"
    ///Post ceell reuse identifiers
    let cellReuseIdentifier = "cellReuseIdentifier"
    
    private var dataSource: UICollectionViewDiffableDataSource<FeedSection, PostViewModel>!
    
    ///delegated used to send scrolling data to the parent view (station)
    var didScrollFeedDelegate: DidScrollFeedDelegate?
    
    ///used to perform data fetching
    private var postPaginator: PostPaginator!
    
    ///to keep reference to the footerView to start/stop animation
    var loadingFooterView: LoadingFooterView?
    
    ///posts displayed in the feed
    //private var posts = [Post]()
    
    ///likes for the posts in the feed
    //private var likesDictionary = [Post: Like]()
    
    //private var postImages = [Post: UIImage]()
    
    //private var postAuthors = [Post: User]()
    
    //private var authorsImages = [User: UIImage]()

    ///FINAL data model for the post
    private var postViewModel = [PostViewModel]()
    
    ///provided by
    private var userID: String?
    
    let semaphore = DispatchSemaphore(value: 1)//temp
    
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
    func setupFeed(feedType: FeedType, userID: String? = nil){
        switch feedType {
        case .lounge(let stationID):
            if let id = stationID{//station loungefeed
                self.postPaginator = PostPaginator(stationID: id, feedType: .lounge(id))
            } else{//home lounge feed
                self.postPaginator = PostPaginator(feedType: .lounge(nil))
            }
        case .busStop(let stationID):
            if let id = stationID{//station loungefeed
                self.postPaginator = PostPaginator(stationID: id, feedType: .busStop(id))
            } else{//home lounge feed
                self.postPaginator = PostPaginator(feedType: .busStop(nil))
            }
        case .userHistoryFeed(let userID):
                self.postPaginator = PostPaginator(userID: userID)
        case .collegeFeed:
            self.postPaginator = PostPaginator(feedType: .collegeFeed)
        }
        self.userID = userID
        self.resetCollectionViewIfNeeded()
        DispatchQueue.global(qos: .userInitiated).async {
            self.fetchDataWithPagination()
        }
    }
    private func resetCollectionViewIfNeeded(){
        //delete old data
        var initialSnapshot = dataSource.snapshot()
        initialSnapshot.deleteAllItems()
        postViewModel.removeAll()
        //likes.removeAll()
        //likesDictionary.removeAll()
        self.dataSource.apply(initialSnapshot, animatingDifferences: false)
        //reset pagination
        postPaginator?.resetPaginator()
    }
}
//MARK: - CollectionView setup
extension FeedCollectionViewController{
    private func setupCollectionView(){
        collectionView.backgroundColor = Constants.Colors.mainBackground
        self.collectionView?.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        self.collectionView.register(LoadingFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerViewReuseIdentifier)
    }
    private func setupDiffableDatasource(){
        //configure layout for cell and footer
        collectionView.collectionViewLayout = createLayout()
        //configure datasource for cells
        dataSource = .init(collectionView: collectionView, cellProvider: { (collectionView, indexPath, post) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellReuseIdentifier, for: indexPath) as? PostCollectionViewCell else {return UICollectionViewCell()}
            let postViewModel = self.postViewModel[indexPath.item]
            cell.postViewModel = postViewModel
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
        //presentPostFor(indexPath: indexPath, likesDictionary[posts[indexPath.row]])
    }
}
//MARK: - fetchDataWithPagination
extension FeedCollectionViewController {
    private func fetchDataWithPagination(){
        semaphore.wait()
        var fetchedPosts = [Post]()
        var fetchedLikes = [Post: Like]()
        var fetchedPostImages = [Post: UIImage]()
        var fetchedPostAuthors = [Post: User]()
        var fetchedAuthorsImages = [User: UIImage]()
        let group = DispatchGroup()
        group.enter()
        //1. fetch posts
        postPaginator?.queryPostWith() { result in
            switch result {
                case .success(let data):
                    fetchedPosts =  data
                case .failure(let error):
                    print("FeedVC Failed loading posts ", error)
                    group.leave()
                    return
            }
            group.leave()
        }
        group.wait()
        group.enter()
        //1.a fetch postImages
        fetchImagesPosts(data: fetchedPosts) { (result) in
            fetchedPostImages = result
            group.leave()
        }
        group.enter()
        //2. fetch likes
        fetchLikes(data: fetchedPosts) { (result) in
            fetchedLikes = result
            group.leave()
        }
        //3. fetch users
        group.enter()
        fetchUsers(data: fetchedPosts) { (result) in
            fetchedPostAuthors = result
            group.leave()
        }
        group.wait()
        //4. fetch userImages
        group.enter()
        fetchImagesForUsers(data: fetchedPostAuthors) { (result) in
            fetchedAuthorsImages = result
            group.leave()
        }
        //5. apply data to the colection
        group.notify(queue: DispatchQueue.main) {
            let viewModel = fetchedPosts.map({ return PostViewModel(post: $0,
                                                                   postImage: fetchedPostImages[$0],
                                                                   user: fetchedPostAuthors[$0]!,
                                                                   userImage: fetchedAuthorsImages[fetchedPostAuthors[$0]!],
                                                                   like: fetchedLikes[$0] != nil)})
            self.postViewModel.append(contentsOf: viewModel)
            //self.posts.append(contentsOf: fetchedPosts)
            //self.postImages.merge(fetchedPostImages) { (_, new) -> UIImage in new }
            //self.likesDictionary.merge(fetchedLikes) { (_, new) -> Like in new }
            //self.postAuthors.merge(fetchedPostAuthors) { (_, new) -> User in new }
            //self.authorsImages.merge(fetchedAuthorsImages) { (_, new) -> UIImage in new }
            self.applyFetchedDataOnCollectionView(data: viewModel)
            self.semaphore.signal()
        }
    }
}
//MARK: -- Networking
    extension FeedCollectionViewController{
    ///afterter new posts were fetched, this function fetches likes for the posts and updates local posts, likes models and reloads collectionView
    private func fetchUsers(data: [Post], completion: @escaping ([Post: User]) -> Void){
        let group = DispatchGroup()
        var users = [Post: User]()
        for post in data{
            group.enter()
            let query = NetworkManager.shared.db.users.whereField(FirestoreFields.userID.rawValue, isEqualTo: post.authorID)
            NetworkManager.shared.getDocumentsForQuery(query: query) { (data: [User]?, error) in
                if error != nil {
                    print("error loading liked post", error!)
                }else if let user = data?[0]{
                    users[post] = user
                }
                group.leave()
            }
        }
        group.notify(queue: DispatchQueue.global()){
            completion(users)
        }
    }
    ///afterter new posts were fetched, this function fetches likes for the posts and updates local posts, likes models and reloads collectionView
    private func fetchLikes(data: [Post], completion: @escaping ([Post: Like]) -> Void){
        let group = DispatchGroup()
        var likes = [Post: Like]()
        for post in data {
            group.enter()
            guard let  id = post.id else {continue}
            let query = NetworkManager.shared.db.likedPosts
                .whereField(FirestoreFields.postID.rawValue, isEqualTo: id)
                .whereField(FirestoreFields.userID.rawValue, isEqualTo: userID ?? "")
            NetworkManager.shared.getDocumentsForQuery(query: query) { (likedPosts: [Like]?, error) in
                if error != nil {
                    print("error loading liked post", error!)
                }else if let like = likedPosts?[0]{
                    likes[post] = like
                }
                group.leave()
            }
        }
        group.notify(queue: DispatchQueue.global()){
            completion(likes)
        }
    }
    func fetchImagesPosts(data: [Post], completion: @escaping ([Post: UIImage]) -> Void) {
        let group = DispatchGroup()
        var imagesDict = [Post: UIImage]()
        for post in data{
            guard let url = post.imageURL else {continue}
            group.enter()
            URLSession.shared.dataTask(with: url) { (data, _, error) in
                if let error = error {
                    print("Error in downloding image: \(error)")
                    //completion(nil, error)
                }
                else if let data = data {
                    let image = UIImage(data: data)
                    imagesDict[post]=image
                    //completion(image, nil)

                }
                group.leave()
            }.resume()
        }
        group.notify(queue: DispatchQueue.global()){
            completion(imagesDict)
        }
        //        let group = DispatchGroup()
        //        var imagesDict = [Post: UIImage]()
        //        for post in data{
        //            group.enter()
        //            NetworkManager.shared.getAsynchImage(withURL: post.imageURL) { (image, err) in
        //                if let image = image {
        //                    imagesDict[post]=image
        //                }
        //                group.leave()
        //            }
        //        }
        //        //group.wait()
        //        group.notify(queue: DispatchQueue.global()){
        //            completion(.success(imagesDict))
        //        }
    }
    func fetchImagesForUsers(data: [Post: User], completion: @escaping ([User: UIImage]) -> Void) {
        let group = DispatchGroup()
        var imagesDict = [User: UIImage]()
        for (_, user) in data{
            group.enter()
            NetworkManager.shared.getAsynchImage(withURL: user.photoURL) { (image, err) in
                if let image = image {
                    imagesDict[user]=image
                }
                group.leave()
            }
        }
        group.notify(queue: DispatchQueue.global()){
            completion(imagesDict)
        }
    }
        
}
//MARK:
extension FeedCollectionViewController {
    ///when users scrolls to the bottom of the loaded data, more data is fetched
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView.isTracking || scrollView.isDragging || scrollView.isDecelerating) {
            didScrollFeedDelegate?.didScrollFeed(scrollView)
            //FIXME: - figureout when its okay to call fetching ><
            let position = scrollView.contentOffset.y
            if position < 0 {
                return
            }
            if position > (collectionView.contentSize.height-100-scrollView.frame.size.height) && collectionView.contentSize.height > 0{
                guard let paginator = postPaginator else {return}
                if (paginator.isFetching) {return}//we fetching data, no need to fetch more
                self.loadingFooterView?.startAnimating() //animation stops when data is done fetching
                DispatchQueue.global(qos: .userInitiated).async {
                    self.fetchDataWithPagination()
                }
            }
        }
    }
    private func applyFetchedDataOnCollectionView(data: [PostViewModel]){
        self.loadingFooterView?.stopAnimating()
        self.collectionView.refreshControl?.endRefreshing()
        var snapshot = NSDiffableDataSourceSnapshot<FeedSection, PostViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(self.postViewModel, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
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
        DispatchQueue.global(qos: .userInitiated).async {
            self.fetchDataWithPagination()
        }
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
            //posts[indexPath.item].likes += 1
            //postViewModel[indexPath.item].likes += 1
            //3. change in the DB
            writeLikeToTheFirestore(with: indexPath)
        } else{
            //1. change UI
            cell.changeCellToDisliked()
            //2. change locally
            //posts[indexPath.item].likes -= 1
            //postViewModel[indexPath.item].likes -= 1
            //3. change in the DB
            deleteLikeFromFirestore(with: indexPath)
        }
    }
    func didTapCommentsButton(_ indexPath: IndexPath) {
        //presentPostFor(indexPath: indexPath, likesDictionary[posts[indexPath.row]])
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
//        let postvc = PostViewController(post: posts[indexPath.row], like: like, indexPath: indexPath)
//        postvc.hidesBottomBarWhenPushed = true
//        postvc.updatePostDelegate = self
//        self.navigationController?.pushViewController(postvc, animated: true)
    }
    private func presentStationFor(indexPath: IndexPath){
        NetworkManager.shared.getDocumentForID(collection: .stations, uid: postViewModel[indexPath.row].stationID) { (document: Station?, error) in
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
//        let vc = OtherProfileViewController(user: posts[indexPath.row].userInfo)
//        self.navigationController?.pushViewController(vc, animated: true)
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
        //FIXME: post
        //posts[indexPath.item].commentCount = post.commentCount
        if status == .add || status == .delete{
            didTapLikeButton(indexPath, cell)
        }
        //3.trigger reload
        var snapshot = dataSource.snapshot()
        snapshot.reloadItems([selectedPost])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    
}

