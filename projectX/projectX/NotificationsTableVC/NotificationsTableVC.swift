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

class NotificationsTableVC: UIViewController {
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.text = "Mailroom"
        label.textAlignment = .center
        return label
    }()
    
    let segmentController: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Notifications", "Missions"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 0
        sc.layer.backgroundColor = UIColor.white.cgColor
        sc.addTarget(self, action: #selector(performAnimation), for: .valueChanged)
        return sc
    }()
    
    
    // should we add another label to preview the actually reply of the person?
    
    
    // make sure all lists have the same count
    let notifications = ["UCSC's Channel will be undergoing a scheduled maintenance at 10pm PST. Click to learn more.","Hello fellow slugs, it's time to support our vets! Please join us in the Stevenson Lounge from 12pm to 2pm as we will be holding a fundraiser for our vets and host a ton of fun activities. See ya soon!","Freddy Mercury liked your post in the Gaming Station, check it out!","The wrestling season is starting soon! We're looking for big boy slugs, not skinny wimps. Click to learn more.", "Freddy Mercury replied to your post in the Gaming Station, check it out!"]
    let notificationspic = ["sluglogoo.png", "slugvet.png", "xbox.png", "bigslug.png", "xbox.png"]
    let notificationsdate = ["1h", "5h", "1d", "2y", "5y"]
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.tableFooterView = UIView()
      
        tableView.delegate = self
        tableView.dataSource = self
      
        tableView.register(NotificationCell.self, forCellReuseIdentifier: NotificationCell.CellID)
        tableView.rowHeight = UITableView.automaticDimension
       
        tableView.estimatedRowHeight = 100
        self.view.addSubview(titleLabel)
        self.view.addSubview(segmentController)
        self.view.addSubview(tableView)
        
        let titleLabelTop = titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 32)
        let titleLabelLeft = titleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32)
        let segmentControllerTop = segmentController.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        let segmentControllerWidth = segmentController.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        
        tableView.addAnchors(top: segmentController.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)

        NSLayoutConstraint.activate([titleLabelTop, titleLabelLeft,segmentControllerTop, segmentControllerWidth])
        
    }
   
    
    @objc func performAnimation(){
        
    }
    
    
}

extension NotificationsTableVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCell.CellID, for: indexPath) as? NotificationCell else {
                   fatalError("Wrong cell")
               }
            
               addData1(toCell: cell, withIndex: indexPath.row)
               return cell
        
        
        
        
        
        
        
        
      
    }

    func addData1(toCell cell: NotificationCell, withIndex index: Int ){
        cell.dateUILabel.text = notificationsdate[index]
        cell.previewtxtLabel.text = notifications[index]
        cell.notifimage.image = UIImage(named: notificationspic[index])
        
        
        
    }
    

}



