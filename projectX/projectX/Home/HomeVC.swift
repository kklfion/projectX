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

enum Section {
    case main
}

class HomeTableVC: UICollectionViewController, UISearchBarDelegate{
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Post>!
    
    //TODO: not implemented (searching isn't straightforward with firestore)
    private let searchController = UISearchController(searchResultsController: nil)
    
    ///used to perform data fetching
    private var postPaginator = PostPaginator()
    
    ///to keep reference to the footerView to start/stop animation
    var loadingFooterView: LoadingFooterView?
    
    ///reuse identifiers
    let footerViewReuseIdentifier = "footerViewReuseIdentifier"
    let cellReuseIdentifier = "cellReuseIdentifier"
    
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
        setupDiffableDatasource()
        setupNavigationBar()
        fetchDataWith(pagination: false)
  
    }
    //MARK: CollectionView setup
    private func setupCollectionView(){
        collectionView.backgroundColor = .white
        self.collectionView?.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: self.cellReuseIdentifier)
        self.collectionView.register(LoadingFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: self.footerViewReuseIdentifier)
    }
    private func setupDiffableDatasource(){
        //configure layout for cell and footer
        collectionView.collectionViewLayout = createLayout()
        //configure datasource for cells
        dataSource = .init(collectionView: collectionView, cellProvider: { (collectionView, indexPath, post) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellReuseIdentifier, for: indexPath) as! PostCollectionViewCell
            self.addData(toCell: cell, withPost: post)
            cell.delegate = self
            cell.indexPath = indexPath
            return cell
        })
        //configure datasource for footer view
        dataSource.supplementaryViewProvider = .some({ (collectionView, kind, indexPath) -> UICollectionReusableView? in
            if kind == UICollectionView.elementKindSectionFooter {
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.footerViewReuseIdentifier, for: indexPath) as! LoadingFooterView
                self.loadingFooterView = view
                self.loadingFooterView?.backgroundColor = .clear
                self.loadingFooterView?.startAnimating() //animation stops when data is done fetching
                return view
            }else {
                return nil
            }
        })
        collectionView.dataSource = dataSource
    }
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.25))
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
    }
    ///Initial fetch should be done with pagination false, all other calls with pagination true
    private func fetchDataWith(pagination: Bool){
        postPaginator.queryPostWith(pagination: pagination) { [weak self] result in
            switch result {
                case .success(let data):
                    DispatchQueue.global(qos: .userInitiated).async { //global queue to prevent app from freezing while waiting
                        self?.updatePostsAndLikesWith(posts: data)
                    }
                case .failure(let error):
                    print("HomeVC Failed loading data ", error)
            }
        }
    }
    ///when users scrolls to the bottom of the loaded data, more data is fetched
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (collectionView.contentSize.height-100-scrollView.frame.size.height){
            if postPaginator.isFetching {return}//we fetching data, no need to fetch more
            fetchDataWith(pagination: true)
        }
    }
    ///afterter new posts were fetched, this function fetches likes for the posts and updates local posts, likes models and reloads collectionView
    private func updatePostsAndLikesWith(posts: [Post]){
        let group = DispatchGroup()
        for doc in posts {
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
                }
                group.leave()
            }
        }
        group.wait()
        DispatchQueue.main.async {
            self.applyFetchedDataOnCollectionView(with: posts)
        }
    }
    private func applyFetchedDataOnCollectionView(with posts: [Post]){
        self.posts.append(contentsOf: posts)
        self.loadingFooterView?.stopAnimating()
        //APPLY snapshot
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Post>()
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(self.posts)
        self.dataSource.apply(initialSnapshot, animatingDifferences: true)
    }
    ///when app is loaded and user isnt signed in, login screen is presented
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
    //TODO: move to cell
    private func addData(toCell cell: PostCollectionViewCell, withPost post: Post ){
        //cell.isLiked = false
        cell.postImageView.image = nil
        cell.titleLabel.text =  post.title
        cell.messageLabel.text =  post.text
        cell.authorLabel.text =  post.userInfo.name
        cell.likesLabel.text =  String(post.likes)
        cell.commentsLabel.text =  String(post.commentCount)
        cell.stationButton.setTitle(post.stationName, for: .normal)
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let dateString = formatter.string(from: post.date)
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
}
extension HomeTableVC: PostCollectionViewCellDidTapDelegate{
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
    private func writeLikeToTheFirestore(with indexPath: IndexPath) {
        guard  let userID = UserManager.shared().user?.userID else {return}
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

