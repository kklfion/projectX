//
//  MainTabBarVC.swift
//  projectX
//
//  Created by Radomyr Bezghin on 6/13/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

protocol TabBarSideBarDelegate {
    func handleMenuToggle()
}

class MainTabBarVC: UITabBarController, UITabBarControllerDelegate {
    
    var tabBarDelegate: TabBarSideBarDelegate?
    
    var sidebar: SidebarVC!
    var newPost: NewPostVC!
    var home: HomeTableVC!
    var notifications: NotificationsTableVC!
    var profile: ProfileTableVC!
    let imageSize = 25 //used to size image for tabbar items
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        //create items&images
        let sidebarItem = UITabBarItem()
        sidebarItem.image = createSizedImage(named: "menu_icon", size: imageSize)
        let newPostItem = UITabBarItem()
        newPostItem.image = createSizedImage(named: "newpost_icon", size: imageSize)
        let homeItem = UITabBarItem()
        homeItem.image = createSizedImage(named: "home_icon", size: imageSize)
        let notificationsItem = UITabBarItem()
        notificationsItem.image = createSizedImage(named: "notifications_icon", size: imageSize)
        let profileItem = UITabBarItem()
        profileItem.image = createSizedImage(named: "profile_icon", size: imageSize)
        
        sidebar = SidebarVC()
        sidebar.tabBarItem = sidebarItem
        newPost = NewPostVC()
        newPost.tabBarItem = newPostItem
        home = HomeTableVC()
        home.tabBarItem = homeItem
        notifications = NotificationsTableVC()
        notifications.tabBarItem = notificationsItem
        profile = ProfileTableVC() // maybe need a container VC that has two other VCs
        profile.tabBarItem = profileItem
        
        self.viewControllers = [sidebar,home,newPost,notifications,profile]
        self.selectedIndex = 2

        
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.isKind(of: NewPostVC.self){
            let newPost = NewPostVC()
            self.present(newPost, animated: true)
            return false
        }
        else if viewController.isKind(of: SidebarVC.self){
            tabBarDelegate?.handleMenuToggle()
            print("selected menu")
            //performAnimation(tabBarController)
            return false
        }

        return true
    }
    func createSizedImage(named: String, size: Int)  -> UIImage {
        let image = UIImage(named: named)!
        //resizing image
        let size = CGSize(width: size, height: size)
        var newImage: UIImage
        let renderer = UIGraphicsImageRenderer(size: size)
        newImage = renderer.image { (context) in
             image.draw(in: CGRect(origin: .zero, size: size))
        }
        return newImage
    }
}


