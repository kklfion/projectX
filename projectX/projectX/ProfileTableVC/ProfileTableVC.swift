//
//  ProfileTableVC.swift
//  projectX
//
//  Created by Radomyr Bezghin on 6/15/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit
import FirebaseAuth
import Combine

class ProfileTableVC: UIViewController {
    let userManager = UserManager.shared
    var profileView: ProfileView?
    private var postData = FakePostData().giveMeSomeData()
    
    override func viewDidLoad() {
        postData.shuffle()
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupTableViews()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getUserInformation()
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
        
        profileView?.loungeTableView.register(PostCellWithImage.self, forCellReuseIdentifier: PostCellWithImage.cellID)
        profileView?.loungeTableView.register(PostCellWithoutImage.self, forCellReuseIdentifier: PostCellWithoutImage.cellID)
        profileView?.missionsTableView.register(PostCellWithImage.self, forCellReuseIdentifier: PostCellWithImage.cellID)
        profileView?.missionsTableView.register(PostCellWithoutImage.self, forCellReuseIdentifier: PostCellWithoutImage.cellID)
    }
    private func getUserInformation(){
        if userManager.user != nil {
            profileView?.profileImageView.image = userManager.userImage
            profileView?.usernameLabel.text = userManager.user?.name
        }else{
            profileView?.usernameLabel.text = ""
            profileView?.profileImageView.image = nil
        }
        
//        let cancellable = userManager.userDataPublisher
//            .sink {  (user) in
//                self.profileView?.usernameLabel.text = self.userManager.user?.name
//            }
        //userManager.setDefaultUser()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCellWithImage.cellID, for: indexPath) as? PostCellWithImage else {
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
    private func addData(toCell cell: PostCellWithImage, withIndex index: Int ){
        cell.titleUILabel.text =  postData[index].title
        cell.previewUILabel.text =  postData[index].preview
        cell.authorUILabel.text =  postData[index].author
        cell.likesLabel.text =  String(postData[index].likesCount)
        cell.commentsUILabel.text =  String(postData[index].commentsCount)
        //cell.UID =  postData[index].postID
        cell.dateUILabel.text = "\(index)h"
        if postData[index].image != nil{
            cell.imageView?.isHidden = false
            //this cell will have an image
            cell.postUIImageView.image = postData[index].image
        }else{
            //change cell constraints so that text takes the extra space
            cell.imageView?.isHidden = true
            cell.postUIImageView.image = nil
        }
    }
}
  


