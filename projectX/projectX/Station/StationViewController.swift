//
//  StationsVC.swift
//  projectX
//
//  Created by Radomyr Bezghin on 8/3/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//
import UIKit

 class StationViewController: UIViewController, UIScrollViewDelegate {
    
    ///presented Station, either a substation or a regular station
    var station: Station?
    
    ///posts for Station are loaded after viewcontroller was loaded
    private var posts = [Post]()
    
    ///missions for Station are loaded after viewcontroller was loaded
    private var missions = [Mission]()

    ///used for calculating sliding up/down header when scrolling
    var headerMaxHeight: CGFloat!
    var statusBarHeight: CGFloat!
    
    lazy var stationView: StationView = {
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        let view = StationView(frame: frame, type: .subStation)
        return view
    }()
    let seachView: UISearchBar = {
        let sb = UISearchBar()
        sb.showsCancelButton = true
        return sb
    }()

    override func viewDidLoad() {
        view.backgroundColor = .white
        setupView()
        setupHeights()
        setupTableView(tableView: stationView.tableViewAndCollectionView?.loungeTableView ?? nil)
        setupBulletinBoardTableView()
        setupStationHeaderWithStation()
        loadDataForStation()
    }
    ///fetches posts and missions for station
    private func loadDataForStation(){
        guard let  id = station?.id else {return}
        //fetch posts
        var query = NetworkManager.shared.db.posts.whereField(FirestoreFields.stationID.rawValue, isEqualTo: id)
        NetworkManager.shared.getDocumentsForQuery(query: query) { (posts: [Post]?, error) in
            if error != nil{
                print("Error loading posts for station \(String(describing: error?.localizedDescription))")
            }else if posts != nil{
                self.posts = posts!
                self.stationView.tableViewAndCollectionView?.loungeTableView.reloadData()
            }
        }
        //fetch missions
        query = NetworkManager.shared.db.missions.whereField(FirestoreFields.stationID.rawValue, isEqualTo: id)
        NetworkManager.shared.getDocumentsForQuery(query: query) { (missions: [Mission]?, error) in
            if error != nil{
                print("Error loading missions for station \(String(describing: error?.localizedDescription))")
            }else if missions != nil{
                self.missions = missions!
                self.stationView.tableViewAndCollectionView?.bulletinBoardCollectionView.reloadData()
            }
        }
    }
    private func setupBulletinBoardTableView(){
        stationView.tableViewAndCollectionView?.bulletinBoardCollectionView.delegate = self
        stationView.tableViewAndCollectionView?.bulletinBoardCollectionView.dataSource = self
        stationView.tableViewAndCollectionView?.bulletinBoardCollectionView.register(BoardCell.self, forCellWithReuseIdentifier: BoardCell.cellID)
        stationView.tableViewAndCollectionView?.bulletinBoardCollectionView.refreshControl = UIRefreshControl()
        //stationView.tableViewsView?.bulletinBoardCollectionView.refreshControl?.addTarget(self, action: #selector(handleTableViewRefresh(_:)), for: UIControl.Event.valueChanged)
    }
    private func setupTableView(tableView: UITableView?){
        guard let tableView = tableView else {return}
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(PostCellWithImage.self, forCellReuseIdentifier: PostCellWithImage.cellID)
        tableView.register(PostCellWithoutImage.self, forCellReuseIdentifier: PostCellWithoutImage.cellID)
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(handleTableViewRefresh(_:)), for: UIControl.Event.valueChanged)
    }
    private func setupStationHeaderWithStation(){
        let followers = station?.followers ?? 0
        stationView.followersLabel.text = "\(followers) followers."
        NetworkManager.shared.getAsynchImage(withURL: station?.backgroundImageURL) { (image, error) in
            if image != nil {
                DispatchQueue.main.async {
                    self.stationView.backgroundImageView.image = image
                }
            }
        }
        NetworkManager.shared.getAsynchImage(withURL: station?.frontImageURL) { (image, error) in
            if image != nil {
                DispatchQueue.main.async {
                    self.stationView.frontImageView.image = image
                }
            }
        }
        stationView.stationInfoLabel.text = station?.info
        stationView.stationNameLabel.text = station?.stationName

    }
    private func setupView(){
        navigationItem.titleView = seachView
        view.addSubview(stationView)
        stationView.addAnchors(top: view.safeAreaLayoutGuide.topAnchor,
                           leading: view.safeAreaLayoutGuide.leadingAnchor,
                           bottom: view.bottomAnchor,
                           trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }
    private func setupHeights(){
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        headerMaxHeight = view.frame.height * 0.3 + 3 //MUST equal to the height of the view's header that is set up in the stationView
    }

    @objc func handleTableViewRefresh(_ refreshControl: UIRefreshControl){
        //load data
        //add it to the tableview
        //self.tableView.reloadData()
        // for now fake loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            refreshControl.endRefreshing()
        }

    }
    // scrollViewDidScroll handles the change in layout when user scrolls
    // offset starts at 0.0
    // goes negative if scroll up(tableview goes down), goes positive if scrolls down(tableView goes up)
    // offet can either be too high(keep maximum offset), to little(keep minimum offstet) or inbetween(can be adjusted)
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y_offset: CGFloat = scrollView.contentOffset.y
        guard  let headerViewTopConstraint = stationView.topViewContainerTopConstraint else {return}
        let newConstant = headerViewTopConstraint.constant - y_offset

        //when scrolling up
        if newConstant <= -headerMaxHeight {
            headerViewTopConstraint.constant = -headerMaxHeight
        //when scrolling down
        }else if newConstant >= 0{
            headerViewTopConstraint.constant = 0
        }else{//inbetween we want to adjust the position of the header
            headerViewTopConstraint.constant = newConstant
            scrollView.contentOffset.y = 0 //to smooth out scrolling
        }
    }
}
extension StationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/2.2, height: self.view.frame.width*0.6)
        }
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
        
        cell.descriptionLabel.text = missions[indexPath.row].text
        NetworkManager.shared.getAsynchImage(withURL: missions[indexPath.row].imageURL) { (image, error) in
            if image != nil {
                DispatchQueue.main.async {
                    cell.boardImageView.image = image
                }
            }
        }
        return cell
    }
}
extension StationViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentPostFor(indexPath: indexPath)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch posts[indexPath.row].imageURL {
        case nil:
            if let cell = tableView.dequeueReusableCell(withIdentifier: PostCellWithoutImage.cellID, for: indexPath) as? PostCellWithoutImage{
                addData(toCell: cell, withIndex: indexPath.row)
                cell.indexPath = indexPath
                cell.delegate = self
                cell.selectionStyle = .none
                return cell
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: PostCellWithImage.cellID, for: indexPath) as? PostCellWithImage{
                cell.postUIImageView.image = nil
                addData(toCell: cell, withIndex: indexPath.row)
                cell.indexPath = indexPath
                cell.delegate = self
                cell.selectionStyle = .none
                return cell
            }
        }
        return UITableViewCell()
    }
    private func addData(toCell cell: PostCellWithoutImage, withIndex index: Int ){
        cell.titleUILabel.text =  posts[index].title
        cell.titleUILabel.text =  posts[index].title
        cell.previewUILabel.text =  posts[index].text
        cell.authorUILabel.text =  posts[index].userInfo.name
        cell.likesLabel.text = "\(posts[index].likes)"
        cell.commentsUILabel.text = "0"
        cell.dateUILabel.text = "\(index)h"
        cell.stationButton.setTitle(posts[index].stationName, for: .normal)

    }
    private func addData(toCell cell: PostCellWithImage, withIndex index: Int ){
        cell.titleUILabel.text =  posts[index].title
        cell.titleUILabel.text =  posts[index].title
        cell.previewUILabel.text =  posts[index].text
        cell.authorUILabel.text =  posts[index].userInfo.name
        cell.likesLabel.text = "\(posts[index].likes)"
        cell.stationButton.setTitle(posts[index].stationName, for: .normal)
        cell.commentsUILabel.text = "0"
        cell.dateUILabel.text = "\(index)h"
        NetworkManager.shared.getAsynchImage(withURL: posts[index].imageURL) { (image, error) in
            DispatchQueue.main.async {
                cell.postUIImageView.image = image
            }
        }
    }
}
extension StationViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
    }
}
//MARK:  handling cell buttons
extension StationViewController: PostCellDidTapDelegate{
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
        let vc = OtherProfileViewController()
        vc.user = posts[indexPath.row].userInfo
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
