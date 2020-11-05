//
//  ProfileTableVC.swift
//  projectX
//
//  Created by Radomyr Bezghin on 6/15/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit
import Firebase
import Combine

class ProfileTableVC: UIViewController {
    
    private var profileView: ProfileView?
    
    //private var userSubscription: AnyCancellable? //not implemented currently
    
    private var posts: [Post]?{
        didSet{
            profileView?.tableViewAndCollectionView?.loungeTableView.reloadData()
        }
    }
    
    private var user: User?
    
    //for now using posts data to create cells
    private var boards: [Post]?{
        didSet{
            profileView?.tableViewAndCollectionView?.bulletinBoardCollectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupTableViews()
        updateProfileInformation()
//        userSubscription = UserManager.shared.userPublisher.sink { (user) in
//            //print("received User in Profile test", user ?? "")
//        }
        switch UserManager.shared.state{
        case .signedIn(let user):
            print("user is signed in \(user)")
            self.user = user
        case .signedOut:
            print("user isnt signed in")
        }
        
    }
    private func getPostsForUser(){
        let userid = user?.userID
        //guard let userid = UserManager.shared.user?.id else {return}
        let query = NetworkManager.shared.db.posts.whereField("userInfo.userID", isEqualTo: userid ?? "")
        NetworkManager.shared.getDocumentsForQuery(query: query) { (posts: [Post]?, error) in
            if error != nil{
                print("Error loading posts for station \(String(describing: error?.localizedDescription))")
            }else if posts != nil{
                self.posts = posts
                self.boards = posts
            }
        }
    }
    private func setupView(){
        profileView = ProfileView(frame: self.view.frame)
        guard let profileView = profileView else {return}
        view.addSubview(profileView)
        profileView.addAnchors(top: view.safeAreaLayoutGuide.topAnchor,
                               leading: view.safeAreaLayoutGuide.leadingAnchor,
                               bottom: view.bottomAnchor,
                               trailing: view.safeAreaLayoutGuide.trailingAnchor)
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
        let (user, image, state) = UserManager.shared.getCurrentUserData()
        switch state {
        case .signedIn:
            print("signedin")
        default:
            print("other cases")
        }
        profileView?.profileImageView.image = image
        profileView?.usernameLabel.text = user?.name
    }
}
extension ProfileTableVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts?.count ?? 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: setup loading data
        guard let post =  posts?[indexPath.row] else {return}
        let postvc = PostViewController(post: post)
        postvc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(postvc, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch posts?[indexPath.row].imageURL {
        case nil:
            if let cell = tableView.dequeueReusableCell(withIdentifier: PostCellWithoutImage.cellID, for: indexPath) as? PostCellWithoutImage{
                addData(toCell: cell, withIndex: indexPath.row)
                cell.selectionStyle = .none
                //cell.channelUIButton.addTarget(self, action: #selector(dummyStation), for: .touchUpInside)
                return cell
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: PostCellWithImage.cellID, for: indexPath) as? PostCellWithImage{
                cell.postUIImageView.image = nil
                addData(toCell: cell, withIndex: indexPath.row)
                cell.selectionStyle = .none
                //cell.channelUIButton.addTarget(self, action: #selector(dummyStation), for: .touchUpInside)
                return cell
            }
        }
        return UITableViewCell()
    }
    @objc private func dummyStation(){
        //TODO: finish use data to load it
        let station = StationViewController()
        station.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(station, animated: true)
    }
    private func addData(toCell cell: PostCellWithoutImage, withIndex index: Int ){
        cell.titleUILabel.text =  posts?[index].title
        cell.titleUILabel.text =  posts?[index].title
        cell.previewUILabel.text =  posts?[index].text
        cell.authorUILabel.text =  posts?[index].userInfo.name
        cell.likesLabel.text = "\(posts?[index].likes ?? 0)"
        cell.commentsUILabel.text = "0"
        cell.dateUILabel.text = "\(index)h"

    }
    private func addData(toCell cell: PostCellWithImage, withIndex index: Int ){
        cell.titleUILabel.text =  posts?[index].title
        cell.titleUILabel.text =  posts?[index].title
        cell.previewUILabel.text =  posts?[index].text
        cell.authorUILabel.text =  posts?[index].userInfo.name
        cell.likesLabel.text = "\(posts?[index].likes ?? 0)"
        cell.commentsUILabel.text = "0"
        cell.dateUILabel.text = "\(index)h"
        NetworkManager.shared.getAsynchImage(withURL: posts?[index].imageURL) { (image, error) in
            DispatchQueue.main.async {
                cell.postUIImageView.image = image
            }
        }
    }
}
extension ProfileTableVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/2.2, height: self.view.frame.width*0.6)
        }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tryCell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardCell.cellID, for: indexPath) as? BoardCell
        guard let cell = tryCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = UIColor.red

        return cell
    }

}
