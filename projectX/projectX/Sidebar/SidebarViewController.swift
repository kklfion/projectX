//
//  SidebarVC.swift
//  projectX
//
//  Created by Radomyr Bezghin on 6/15/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

/// ehh when station is selected in the sidebar homeview presents station
protocol SideBarStationSelectionDelegate {
    func didTapSidebar(station: Station)
}

enum SideBarMenuType{
    case match
    case friends
    case library
    case nightmode
    case settings
}
class SidebarViewController: UIViewController {
    
    private var dbstations: [Station]? = nil{
        didSet{
            sideBarView?.stationsTableView.reloadData()
        }
    }
    
    var sideBarView: SideBarView?
    /// returns what side menu button was tapped to the MainTabBar
    var didTapSideBarMenuType: ((SideBarMenuType) -> Void)?
    var didTapSideBarStationType: ()?
    var sideBarTransitionDelegate: SideBarStationSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideView()
        setupTableViewsDelegates()
        loadStations()
    }
    private func loadStations(){
        let query = NetworkManager.shared.db.stations.whereField(FirestoreFields.stationType.rawValue, in: [StationType.parentStation.rawValue, StationType.station.rawValue])
        NetworkManager.shared.getDocumentsForQuery(query: query) { (documents: [Station]?, error) in
            if documents != nil {
                self.dbstations = documents
            }else {
                print(error?.localizedDescription ?? "Error loading stations")
            }
        }
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
            return dbstations?.count ?? 0
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
            guard let station = self.dbstations?[index] else {return}
            self.sideBarTransitionDelegate?.didTapSidebar(station: station)
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SideBarView.menuCellID, for: indexPath)
        if tableView == sideBarView?.menuTableView{
            let imageName = sideBarView?.imageNames[indexPath.row] ?? ""
            let text = sideBarView?.menuItems[indexPath.row]
            let image = UIImage(systemName: imageName)?.withTintColor(Constants.Colors.darkBrown, renderingMode: .alwaysOriginal)
            cell.textLabel?.text = text
            cell.textLabel?.font = Constants.bodyTextFont
            cell.imageView?.image = image
            cell.selectionStyle = .none
            cell.contentView.backgroundColor = Constants.Colors.secondaryBackground
        }
        else{ //stations
            let text = dbstations?[indexPath.row].stationName
            cell.textLabel?.text = text
            cell.textLabel?.font = Constants.bodyTextFont
            cell.textLabel?.textAlignment = .left
            cell.imageView?.image = nil
            cell.selectionStyle = .none
            cell.contentView.backgroundColor = Constants.Colors.secondaryBackground
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

