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
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        
        collectionView.register(NotificationCell.self, forCellWithReuseIdentifier: NotificationCell.CellID)
        getData()
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
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return notifications.count
//    }
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if tableView == self.notifTableView {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCell.CellID, for: indexPath) as? NotificationCell else {
//                   fatalError("Wrong cell")
//               }
//        addData(toCell: cell, withIndex: indexPath.row)
//        return cell
//        }
//        else if tableView == self.missionTable{
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: MissionsCell.Cell1ID, for: indexPath) as? MissionsCell else {
//                       fatalError("Wrong cell")
//                   }
//            addData1(toCell: cell, withIndex: indexPath.row)
//            return cell
//        }
//        else {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: MissionsCell.Cell1ID, for: indexPath) as? MissionsCell else {
//                                fatalError("Wrong cell")
//                            }
//            return cell
//
//        }
//    }
//
//
//    func addData(toCell cell: NotificationCell, withIndex index: Int ){
//
//        cell.dateUILabel.text = notificationsdate[index]
//        cell.previewtxtLabel.text = notifications[index]
//        cell.notifimage.image = UIImage(named: notificationspic[index])
//    }
//    func addData1(toCell cell: MissionsCell, withIndex index: Int ){
//        cell.dateUILabel.text = missions1date[index]
//        cell.nameUILabel.text = usernames[index]
//        cell.previewtxtLabel.text = missions1[index]
//        cell.selectionUILabel.text = missionactions[index]
//        cell.channelUILabel.setTitle(channels[index], for: .normal)
//        //cell.channelUILabel.text = channels[index]
//        cell.notifimage.image = UIImage(named: notificationspic[index])
//    }
}

//extension NotificationsTableVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return missions.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//
//
//        guard let cell = missionCollection.dequeueReusableCell(
//            withReuseIdentifier: MissionCell.CellID, for: indexPath) as? MissionCell else {fatalError("Wrong cell") }
//
//        addDataMission(toCell: cell, withIndex: indexPath.item)
//        return cell
//    }
//
//    func addDataMission(toCell cell: MissionCell, withIndex index: Int) {
//        cell.deadlineLabel.text = "In \(missionsdate[index])"
//        cell.previewtxtLabel.text = "\"\(missions[index])\""
//        cell.missionImage.image = UIImage(named: missionspic[index])
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.bounds.height - 10, height: collectionView.bounds.height - 10)
//    }
//}
//
//
//extension NotificationsTableVC: UICollectionViewDataSourcePrefetching {
//    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//        print("Prefetch: \(indexPaths)")
//    }
//}
