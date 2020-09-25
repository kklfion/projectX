//
//  SidebarVC.swift
//  projectX
//
//  Created by Radomyr Bezghin on 6/15/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit
enum SideBarMenuType{
    case match
    case friends
    case library
    case nightmode
    case settings
}
class SidebarViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var sideBarView: SideBarView?
    var didTapSideBarMenuType: ((SideBarMenuType) -> Void)? // returns what side menu button was tapped
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
        sideBarView?.menuTableView.register(UITableViewCell.self, forCellReuseIdentifier: SideBarView.CellID)
    }
}
extension SidebarViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideBarView?.menuItems.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SideBarView.CellID, for: indexPath)
        let imageName = sideBarView?.imageNames[indexPath.row] ?? ""
        let text = sideBarView?.menuItems[indexPath.row]
        let image = UIImage(systemName: imageName)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        cell.textLabel?.text = text
        cell.imageView?.image = image
        cell.selectionStyle = .none
        return cell
    }
    
    
}
//MARK: handlers
extension SidebarViewController{
    @objc private func didTapDissmissSidebar(){
        self.dismiss(animated: true)
    }
}
