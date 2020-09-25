//
//  MainTabBarVC.swift
//  projectX
//
//  Created by Radomyr Bezghin on 6/13/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit
class MainTabBarVC: UITabBarController {
    let transition = SideBarSlidingTransition() // for custom transitioning of the sidebar
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupNavigationBarAppearance()
        setupSideBarItems()
    }
    private func setupSideBarItems(){
        let sidebarItem = UITabBarItem()
        sidebarItem.image = UIImage(systemName: "sidebar.left")
        sidebarItem.title = "Sidebar"
        let newPostItem = UITabBarItem()
        newPostItem.image = UIImage(systemName: "pencil")
        newPostItem.title = "New Post"
        let homeItem = UITabBarItem()
        homeItem.image = UIImage(systemName: "house")
        homeItem.title = "Home"
        let notificationsItem = UITabBarItem()
        notificationsItem.image = UIImage(systemName: "envelope")
        notificationsItem.title = "Mailroom"
        let profileItem = UITabBarItem()
        profileItem.image = UIImage(systemName: "person")
        profileItem.title = "Profile"
        
        let sidebar = SidebarViewController()
        sidebar.tabBarItem = sidebarItem
        let newPost = NewPostVC()
        newPost.tabBarItem = newPostItem
        let home = HomeTableVC()
        home.tabBarItem = homeItem
        let homeNav = UINavigationController(rootViewController: home)
        let notifications = NotificationsTableVC()
        notifications.tabBarItem = notificationsItem
        let notigicationsNav = UINavigationController(rootViewController: notifications)
        let profile = ProfileTableVC()
        profile.tabBarItem = profileItem
        let profileNav = UINavigationController(rootViewController: profile)
    
        self.viewControllers = [sidebar,homeNav,newPost,notigicationsNav,profileNav]
        self.selectedIndex = 1
    }
    private func setupNavigationBarAppearance(){
        UINavigationBar.appearance().tintColor = .systemBlue
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().shadowImage = UIImage()
    }
}
//MARK: handling special cases of tabbar items
extension MainTabBarVC: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.isKind(of: NewPostVC.self){
            let vc = NewPostVC()
            self.present(vc, animated: true)
            return false
        }
        else if viewController.isKind(of: SidebarViewController.self){
            let vc = SidebarViewController()
            vc.didTapSideBarMenuType = { menuType in
                self.transitionToNew(menuType)
            }
            vc.modalPresentationStyle = .overCurrentContext
            vc.transitioningDelegate = self
            self.present(vc, animated: true)
            return false
        }
        return true
    }
    private func transitionToNew(_ menuType: SideBarMenuType){
        switch menuType {
        case .settings:
            print("FUCK me")
            //let settings = SettingsTableViewController()
            //self.present(settings, animated: true)
        default:
            print("error selecting sidebar menu")
        }
    }
}
//MARK: handling sidebar slideout animation -> SideBarSlidingTransition
extension MainTabBarVC: UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}


