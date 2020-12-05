//
//  NotificationsTableVC.swift
//  projectX
//
//  Created by Radomyr Bezghin on 6/15/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//
 /*
 create a separate UIView file and do all the autolayout there
 init a view of that type here in UIView Controller and pin it to the edges
 
 UIView file
 Segmented controll
 UITableView vertical
 -> custom cell, separate file of type UITableViewCell
 */



import UIKit


class NotificationsTableVC: UICollectionViewController {
    
    private var notifications = [Notification]()
    
    init(){
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Mailroom"
        let search = UISearchController(searchResultsController: nil)
        navigationItem.searchController = search
        
        collectionView.register(NotificationCell.self, forCellWithReuseIdentifier: NotificationCell.CellID)
        getData()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = Constants.yellowColor
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    private func getData(){
        let query = NetworkManager.shared.db.notifications
        NetworkManager.shared.getDocumentsForQuery(query: query) { (notifications: [Notification]? , error) in
            if error != nil{
                print("Error loading posts for home \(String(describing: error?.localizedDescription))")
            }else if notifications != nil{
                self.notifications = notifications!
                self.notifications.append(contentsOf: notifications!)
                self.collectionView.reloadData()
            }
        }
    }
}

extension NotificationsTableVC: UICollectionViewDelegateFlowLayout{
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            .init(width: view.frame.width, height: 120)
        }
        override func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return notifications.count
        }
        override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            //presentPostFor(indexPath: indexPath)
        }
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotificationCell.CellID, for: indexPath) as? NotificationCell else {return UICollectionViewCell()}
            addData(toCell: cell, withIndex: indexPath.row)
            return cell
        }

        func addData(toCell cell: NotificationCell, withIndex index: Int ){
            cell.dateLabel.text = notifications[index].timestamp.description
            cell.textLabel.text = notifications[index].preview
            cell.notificationImageView.image = UIImage(named: notifications[index].image)
        }
}

