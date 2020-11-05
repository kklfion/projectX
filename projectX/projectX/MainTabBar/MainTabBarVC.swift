//
//  MainTabBarVC.swift
//  projectX
//
//  Created by Radomyr Bezghin on 6/13/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
// radomirbezgin@gmail.com
// 123456


import UIKit
import FirebaseAuth
import Firebase

class MainTabBarVC: UITabBarController {
    /// custom sidebar transition
    let sideBarTransition = SideBarSlidingTransition()
    /// has to be global, bc I need to set sidebars delegate = homeview
    /// so that homeview can present selected station
    let home = HomeTableVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupNavigationBarAppearance()
        setupSideBarItems()
        setupTabBarAppearance()

        ///test
        tempQueries()
    }
    private func tempQueries(){
//        let user = User(name: "Radomyr Bezghin",
//                        photoURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/defaultUserIcon.png?alt=media&token=2e6edb8e-ac03-47fb-b58c-31bd6f3598e8"),
//                        email: "radomirbezgin@gmail.com", uid: "59qIdPL8uAfltJryIrAWfQNFcuN2")
//
//        let mission = Mission(stationID: "vpuu9oIPMkkxxRh3qINU",
//                              stationName: "UC Santa Cruz",
//                              likes: 0,
//                              userInfo: user,
//                              title: "Fix my brain",
//                              text: "test mission #2",
//                              date: Date(),
//                              imageURL: nil)

//        let acceptedMission = AcceptedMissions(userID: "59qIdPL8uAfltJryIrAWfQNFcuN2", missionID: "jbq6fTixiEoQn6LhyAIL", date: Date())
        
//        NetworkManager.shared.writeDocumentsWith(collectionType: .missions, documents: [mission]) { (error) in
//            if error != nil {
//                print(error)
//            }
//        }
        
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
    private func setupTabBarAppearance(){
        tabBar.layer.masksToBounds = true
        tabBar.isTranslucent = true
        tabBar.barStyle = .default
        tabBar.layer.cornerRadius = 20
    }
}
//MARK: handling special cases of tabbar items
/// newPost and sidebar have special animation
/// if some menu options were selected they will be presented full screen.
/// if station options were selected tabbar selected item is set to 1
extension MainTabBarVC: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.isKind(of: NewPostVC.self){
            setupNewPostVC(tabBarController)
            return false
        }
        else if viewController.isKind(of: SidebarViewController.self){
            setupSideBarVC(tabBarController)
            return false
        }
        return true
    }
    private func setupNewPostVC(_ tabBarController: UITabBarController){
        let vc = NewPostVC()
        self.present(vc, animated: true)
    }
    private func setupSideBarVC(_ tabBarController: UITabBarController){
        let vc = SidebarViewController()
        vc.sideBarTransitionDelegate = home
        vc.transitioningDelegate = self
        vc.didTapSideBarMenuType = { menuType in
            self.transitionToNew(menuType)
        }
        vc.didTapSideBarStationType = { 
            tabBarController.selectedIndex = 1
        }()
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    private func transitionToNew(_ menuType: SideBarMenuType){
        switch menuType {
        case .settings:
            self.present(SettingsTableViewController(), animated: true)
        default:
            print("error selecting sidebar menu")
        }
    }
}
//MARK: handling sidebar slideout animation -> SideBarSlidingTransition
extension MainTabBarVC: UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        sideBarTransition.isPresenting = true
        return sideBarTransition
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        sideBarTransition.isPresenting = false
        return sideBarTransition
    }
}

