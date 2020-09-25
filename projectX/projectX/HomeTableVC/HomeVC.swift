//
//  HomeTableVC.swift
//  projectX
//
//  Created by Radomyr Bezghin on 6/15/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//
//
import UIKit
import FirebaseFirestore
class HomeTableVC: UIViewController{
    var postData = [Post]()
    private var homeView: HomeView?

    private let seachView: UISearchBar = {
        let sb = UISearchBar()
        sb.showsCancelButton = true
        return sb
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        getData()
        setupView()
        setupTableViewsDelegates()
        setupSearchController()
    }
    private func setupView(){
        self.view.backgroundColor = .white
        homeView = HomeView(frame: self.view.frame)
        homeView?.backgroundColor = .white
        view.addSubview(homeView!)
        homeView?.addAnchors(top: self.view.topAnchor,
                             leading: self.view.leadingAnchor,
                             bottom: self.view.bottomAnchor,
                             trailing: self.view.trailingAnchor)
    }
    private func setupTableViewsDelegates(){
        homeView?.loungeTableView.delegate = self
        homeView?.busStopTableView.delegate = self
        homeView?.loungeTableView.dataSource = self
        homeView?.busStopTableView.dataSource = self
        
        homeView?.loungeTableView.rowHeight = UITableView.automaticDimension
        homeView?.loungeTableView.estimatedRowHeight = 100
        homeView?.busStopTableView.rowHeight = UITableView.automaticDimension
        homeView?.busStopTableView.estimatedRowHeight = 100
        
        homeView?.loungeTableView.register(PostCell.self, forCellReuseIdentifier: Constants.PostCellID)
        homeView?.busStopTableView.register(PostCell.self, forCellReuseIdentifier: Constants.PostCellID)
    }
    /// setup top seatchBar to seatch for particular posts
    private func setupSearchController(){
        navigationItem.titleView = seachView
    }
    
    func getData(){
        //Pagnating the Data TO DO
        //let first = db.collection("posts")
        // .order(by: "population")
        // .limit(to: 25)
        let db = Firestore.firestore()
        var query: Query!
        
        if postData.isEmpty {
            query = db.collection("posts")
            print("First 10 loded")
        }else{
            //query = db.collection("posts").start(afterDocument: lastDocument)
        }
        
        query.getDocuments { (snapshot, error) in
            if let error = error {
                print("\(error.localizedDescription)")
            } else {
                for document in snapshot!.documents{
                    
                    let result = Result {
                        try document.data(as: Post.self)
                    }
                    switch result{
                    case .success(let post):
                        if let post = post {
                            //succesfully initalized
                            self.postData.append(post)
                            print("document succesfully read")
                        }else{
                            //nil value
                            print("Document dosent exsist")
                        }
                    case .failure(let error):
                        print("Error decoding post: \(error)")
                    }
                }
                self.homeView?.loungeTableView.reloadData()
            }
        }
    }
    

}
extension HomeTableVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
extension HomeTableVC: UITableViewDelegate, UITableViewDataSource{
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
        if tableView == homeView?.loungeTableView{
            
        }else if  tableView == homeView?.busStopTableView{
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
        cell.previewUILabel.text =  postData[index].text
        
        cell.authorUILabel.text =  postData[index].userInfo.name

        
        cell.likesUILabel.text =  String(postData[index].likes!)
        cell.commentsUILabel.text =  "0"
        //cell.UID =  postData[index].postID
        cell.dateUILabel.text = "\(index)"
        if postData[index].imageURL != nil{
            //this cell will have an image
            //Converting URL to UiImage object
            let imageTest = UIImageView()
            imageTest.load(url: postData[index].imageURL!)
            cell.postUIImageView.image = imageTest.image
            cell.withImageViewConstraints()
        }else{
            //change cell constraints so that text takes the extra space
            cell.imageView?.isHidden = true
            cell.postUIImageView.image = nil
            cell.noImageViewConstraints()
        }
    }
}


