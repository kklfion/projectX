//
//  ProfileTableVC.swift
//  projectX
//
//  Created by Radomyr Bezghin on 6/15/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileTableVC: UIViewController {
    var profileView: ProfileView?
    private var postData = FakePostData().giveMeSomeData()
    
    override func viewDidLoad() {
        postData.shuffle()
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupTableViews()
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
        profileView?.loungeTableView.delegate = self
        profileView?.missionsTableView.delegate = self
        profileView?.loungeTableView.dataSource = self
        profileView?.missionsTableView.dataSource = self
        
        profileView?.loungeTableView.rowHeight = UITableView.automaticDimension
        profileView?.loungeTableView.estimatedRowHeight = 100
        profileView?.missionsTableView.rowHeight = UITableView.automaticDimension
        profileView?.missionsTableView.estimatedRowHeight = 100
        
        profileView?.loungeTableView.register(PostCell.self, forCellReuseIdentifier: Constants.PostCellID)
        profileView?.missionsTableView.register(PostCell.self, forCellReuseIdentifier: Constants.PostCellID)
    }
    @objc func logoutCurrentUser(){
        // TO DO: Send to loginviewcontroller
        if Auth.auth().currentUser != nil {
            do{
                print("signing out")
                try Auth.auth().signOut()
                
            } catch let error{
                print(error)
            }
        }
    }
}
extension ProfileTableVC: UITableViewDelegate, UITableViewDataSource{
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.PostCellID, for: indexPath) as? PostCell else {
            fatalError("Wrong cell at ?cellForRowAt? ")
        }
        if tableView == profileView?.loungeTableView{
            
        }else if  tableView == profileView?.missionsTableView{
        }
        cell.channelUIButton.addTarget(self, action: #selector(dummyStation), for: .touchUpInside)
        addData(toCell: cell, withIndex: indexPath.row)
        return cell
    }
    @objc private func dummyStation(){
        //TODO: finish use data to load it
        let station = StationsVC()
        station.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(station, animated: true)
    }
    private func addData(toCell cell: PostCell, withIndex index: Int ){
        cell.titleUILabel.text =  postData[index].title
        cell.previewUILabel.text =  postData[index].preview
        cell.authorUILabel.text =  postData[index].author
        cell.likesUILabel.text =  String(postData[index].likesCount)
        cell.commentsUILabel.text =  String(postData[index].commentsCount)
        //cell.UID =  postData[index].postID
        cell.dateUILabel.text = "\(index)h"
        if postData[index].image != nil{
            cell.imageView?.isHidden = false
            //this cell will have an image
            cell.postUIImageView.image = postData[index].image
            cell.withImageViewConstraints()
        }else{
            //change cell constraints so that text takes the extra space
            cell.imageView?.isHidden = true
            cell.postUIImageView.image = nil
            cell.noImageViewConstraints()
        }
    }
}
  


