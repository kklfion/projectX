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

class HomeTableVC: UICollectionViewController{
    
    let searchController = UISearchController(searchResultsController: nil)
    
    private var posts = [Post]()

    init(){
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        extendedLayoutIncludesOpaqueBars = true

        signInUserIfNeeded()
        setupCollectionView()
        getData()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = Constants.yellowColor
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        //navigationController?.navigationBar.layer.cornerRadius = 25
        //navigationController?.navigationBar.clipsToBounds = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    private func setupCollectionView(){
        collectionView.backgroundColor = .white
        collectionView.isPrefetchingEnabled = false
        self.collectionView?.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.cellID)
        self.navigationItem.title = "Home"
        navigationItem.searchController = searchController
    }
    private func getData(){
        let query = NetworkManager.shared.db.posts
        NetworkManager.shared.getDocumentsForQuery(query: query) { (posts: [Post]? , error) in
            if error != nil{
                print("Error loading posts for home \(String(describing: error?.localizedDescription))")
            }else if posts != nil{
                self.posts = posts!
                self.collectionView.reloadData()
            }
        }
    }
    private func signInUserIfNeeded(){
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
extension HomeTableVC: PostCellDidTapDelegate{
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
