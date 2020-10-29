//
//  OtherProfileViewController.swift
//  projectX
//
//  Created by Radomyr Bezghin on 10/22/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

class OtherProfileViewController: UIViewController {
    var user: User?
    private var profileView: ProfileView?
    private var postData = [Post]()
    
    override func viewDidLoad() {
        postData.shuffle()
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
    }
}
extension OtherProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        postData.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: setup loading data
        let postvc = PostViewController()
        postvc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(postvc, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCellWithImage.cellID, for: indexPath) as? PostCellWithImage else {
            fatalError("Wrong cell at ?cellForRowAt? ")
        }
        addData(toCell: cell, withIndex: indexPath.row)
        return cell
    }
    @objc private func dummyStation(){
        //TODO: finish use data to load it
        let station = StationViewController()
        station.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(station, animated: true)
    }
    private func addData(toCell cell: PostCellWithImage, withIndex index: Int ){
        cell.titleUILabel.text =  postData[index].title
        cell.previewUILabel.text =  postData[index].text
        cell.authorUILabel.text =  postData[index].userInfo.name
        cell.likesLabel.text =  String(postData[index].likes)
        cell.commentsUILabel.text =  String(postData[index].commentCount)
        //cell.UID =  postData[index].postID
        cell.dateUILabel.text = "\(index)h"
        if postData[index].imageURL != nil{
            cell.imageView?.isHidden = false
            //this cell will have an image
            let temp = UIImageView()
            temp.load(url: postData[index].imageURL!)
            cell.postUIImageView.image = temp.image
        }else{
            //change cell constraints so that text takes the extra space
            cell.imageView?.isHidden = true
            cell.postUIImageView.image = nil
        }
    }
}
extension OtherProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/2.2, height: self.view.frame.width*0.6)
        }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
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


