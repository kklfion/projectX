//
//  OtherProfileViewController.swift
//  projectX
//
//  Created by Radomyr Bezghin on 10/22/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

class OtherProfileViewController: UIViewController {
    
    ///user displayed by the controller
    var user: User?
    
    ///posts that were created by user
    private var posts = [Post]()
    
    ///missions accepted by the user ? or created?
    private var missions = [Mission]()
    
    ///custom view
    private var profileView: ProfileView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    private func setupTableViews(){
        profileView?.tableViewAndCollectionView?.loungeTableView.delegate = self
        profileView?.tableViewAndCollectionView?.bulletinBoardCollectionView.delegate = self
        profileView?.tableViewAndCollectionView?.loungeTableView.dataSource = self
        profileView?.tableViewAndCollectionView?.bulletinBoardCollectionView.dataSource = self
        
        profileView?.tableViewAndCollectionView?.loungeTableView.rowHeight = UITableView.automaticDimension
        profileView?.tableViewAndCollectionView?.loungeTableView.estimatedRowHeight = 100
        
        profileView?.tableViewAndCollectionView?.loungeTableView.register(PostCellWithImage.self, forCellReuseIdentifier: PostCellWithImage.cellID)
        profileView?.tableViewAndCollectionView?.loungeTableView.register(PostCellWithoutImage.self, forCellReuseIdentifier: PostCellWithoutImage.cellID)
        profileView?.tableViewAndCollectionView?.bulletinBoardCollectionView.register(BoardCell.self, forCellWithReuseIdentifier: BoardCell.cellID)
    }
    private func updateProfileInformation(){
        guard let user = user else{return}
        NetworkManager.shared.getAsynchImage(withURL: user.photoURL) { (image, error) in
            if image != nil {
                DispatchQueue.main.async {
                    self.profileView?.profileImageView.image = image
                }
            }
        }
        profileView?.usernameLabel.text = user.name
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
        print(user.userID)
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
        switch posts[indexPath.row].imageURL {
        case nil:
            if let cell = tableView.dequeueReusableCell(withIdentifier: PostCellWithoutImage.cellID, for: indexPath) as? PostCellWithoutImage{
                addData(toCell: cell, withIndex: indexPath.row)
                cell.selectionStyle = .none
                cell.indexPath = indexPath
                cell.delegate = self
                return cell
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: PostCellWithImage.cellID, for: indexPath) as? PostCellWithImage{
                addData(toCell: cell, withIndex: indexPath.row)
                cell.indexPath = indexPath
                cell.delegate = self
                cell.selectionStyle = .none
                return cell
            }
        }
        return UITableViewCell()
    }
    private func addData(toCell cell: UITableViewCell, withIndex index: Int ){
        if let cell = cell as? PostCellWithImage{
            cell.titleUILabel.text =  posts[index].title
            cell.previewUILabel.text =  posts[index].text
            cell.authorUILabel.text =  posts[index].userInfo.name
            cell.likesLabel.text =  String(posts[index].likes)
            cell.commentsUILabel.text =  String(posts[index].commentCount)
            cell.dateUILabel.text = "\(index)h"
            cell.stationButton.setTitle(posts[index].stationName, for: .normal)

            let temp = UIImageView()
            temp.load(url: posts[index].imageURL!)
            cell.postUIImageView.image = temp.image
        }else if let cell = cell as? PostCellWithoutImage {
            cell.titleLabel.text =  posts[index].title
            cell.messageLabel.text =  posts[index].text
            cell.authorLabel.text =  posts[index].userInfo.name
            cell.likesLabel.text =  String(posts[index].likes)
            cell.commentsLabel.text =  String(posts[index].commentCount)
            cell.stationButton.setTitle(posts[index].stationName, for: .normal)
            cell.dateLabel.text = "\(index)h"
        }
    }
}
extension OtherProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
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
        let vc = OtherProfileViewController()
        vc.user = posts[indexPath.row].userInfo
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


