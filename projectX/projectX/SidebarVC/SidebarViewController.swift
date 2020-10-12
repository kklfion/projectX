//
//  SidebarVC.swift
//  projectX
//
//  Created by Radomyr Bezghin on 6/15/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

protocol SideBarStationSelectionDelegate {
    func didTapSidebarStation(withId stationId: String)
}

enum SideBarMenuType{
    case match
    case friends
    case library
    case nightmode
    case settings
}
class SidebarViewController: UIViewController {
    
    var delegate: SideBarStationSelectionDelegate?{
        didSet{
            print("delegate was set")
        }
    }
        
    let stations = [
        "Travel", "Art", "Drama", "Gaming", "Meme", "Makeup", "Politics","Music",
        "Sports","Food", "Abroad", "Writing","Financial", "Pets", "Job", "Astrology", "Horror",
        "Anime", "LGBTQ+", "Film", "Relationship", "Photography", "International", "Development",
        "Relationship", "Photography", "International", "Development"
    ]
    var sideBarView: SideBarView?
    
    var didTapSideBarMenuType: ((SideBarMenuType) -> Void)? // returns what side menu button was tapped to the MainTabBar
    //var didTapSideBarStationsType: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideView()
        setupTableViewsDelegates()
    }
    private func setupSideView(){
        sideBarView = SideBarView(frame: self.view.frame)
        sideBarView?.cancelButton.addTarget(self, action: #selector(didTapDissmissSidebar), for: .touchUpInside)
        view.addSubview(sideBarView!)
        sideBarView?.addAnchors(top: self.view.topAnchor,
                             leading: self.view.leadingAnchor,
                             bottom: self.view.bottomAnchor,
                             trailing: self.view.trailingAnchor)
    }
    private func setupTableViewsDelegates(){
        
        sideBarView?.menuTableView.delegate = self
        sideBarView?.menuTableView.dataSource = self
        sideBarView?.menuTableView.register(UITableViewCell.self, forCellReuseIdentifier: SideBarView.menuCellID)
        
        sideBarView?.stationsTableView.delegate = self
        sideBarView?.stationsTableView.dataSource = self
        sideBarView?.stationsTableView.register(UITableViewCell.self, forCellReuseIdentifier: SideBarView.menuCellID)
    }
}
extension SidebarViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == sideBarView?.menuTableView{
            return sideBarView?.menuItems.count ?? 0
        }
        else{ //stations
            return stations.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == sideBarView?.menuTableView{
            didTapMenuButtonsFor(indexPath.row)
        }
        else{ //stations
            didTapStationsButtonsFor(indexPath.row)
        }

    }
    func didTapMenuButtonsFor(_ index: Int){
        switch index{
        case 0:
            self.dismiss(animated: true) { [weak self] in
                self?.didTapSideBarMenuType?(SideBarMenuType.match)
            }
        case 1:
            self.dismiss(animated: true) { [weak self] in
                self?.didTapSideBarMenuType?(SideBarMenuType.friends)
            }
        case 2:
            self.dismiss(animated: true) { [weak self] in
                self?.didTapSideBarMenuType?(SideBarMenuType.library)
            }
        case 3:
            self.dismiss(animated: true) { [weak self] in
                self?.didTapSideBarMenuType?(SideBarMenuType.nightmode)
            }
        default:
            self.dismiss(animated: true) { [weak self] in
                self?.didTapSideBarMenuType?(SideBarMenuType.settings)
            }
        }
    }
    func didTapStationsButtonsFor(_ index: Int){
        self.dismiss(animated: true) {
            self.delegate?.didTapSidebarStation(withId: "someID")
        }
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SideBarView.menuCellID, for: indexPath)
        if tableView == sideBarView?.menuTableView{
            let imageName = sideBarView?.imageNames[indexPath.row] ?? ""
            let text = sideBarView?.menuItems[indexPath.row]
            let image = UIImage(systemName: imageName)?.withTintColor(.black, renderingMode: .alwaysOriginal)
            cell.textLabel?.text = text
            cell.imageView?.image = image
            cell.selectionStyle = .none
        }
        else{ //stations
            let text = stations[indexPath.row]
            cell.textLabel?.text = text
            cell.textLabel?.textAlignment = .center
            cell.imageView?.image = nil
            cell.selectionStyle = .none
        }
        return cell
    }
    
    
}
//MARK: handlers
extension SidebarViewController{
    @objc private func didTapDissmissSidebar(){
        self.dismiss(animated: true)
    }
}

