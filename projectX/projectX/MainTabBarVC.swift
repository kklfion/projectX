//
//  MainTabBarVC.swift
//  projectX
//
//  Created by Radomyr Bezghin on 6/13/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

class MainTabBarVC: UITabBarController, UITabBarControllerDelegate {
    
    var sidebar: SidebarVC!
    var newPost: NewPostVC!
    var home: HomeTableVC!
    var notifications: NotificationsTableVC!
    var profile: ProfileTableVC!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //create items&images
        let sidebarItem = UITabBarItem()
        sidebarItem.title = "Side Bar"
        sidebarItem.image = createSizedImage(named: "menu_icon", size: 25)
        let newPostItem = UITabBarItem()
        newPostItem.title = "New Post"
        newPostItem.image = createSizedImage(named: "newpost_icon", size: 25)
        let homeItem = UITabBarItem()
        homeItem.title = "Home"
        homeItem.image = createSizedImage(named: "home_icon", size: 25)
        let notificationsItem = UITabBarItem()
        notificationsItem.title = "Notifications"
        notificationsItem.image = createSizedImage(named: "notifications_icon", size: 25)
        let profileItem = UITabBarItem()
        profileItem.title = "Profile"
        profileItem.image = createSizedImage(named: "profile_icon", size: 25)
        
        
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
        
        self.viewControllers = [sidebar,newPost,home,notifications,profile]
        self.selectedIndex = 2

        
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 1{
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
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
