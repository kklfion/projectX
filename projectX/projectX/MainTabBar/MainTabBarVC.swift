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
    ///tabbaritems configuration
    let tabBarSymbolsConfiguration = UIImage.SymbolConfiguration(weight: .semibold)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupNavigationBarAppearance()
        setupSideBarItems()
        setupTabBarAppearance()
        write()
    }
    func write(){


    }
    private func setupSideBarItems(){
        let sidebar = createViewController(tabBarItemImageName: "sidebar.left", title: "Sidebar", controller: SidebarViewController())
        let newPost = createViewController(tabBarItemImageName: "pencil", title: "New Post", controller: NewPostVC())
        _ = createViewController(tabBarItemImageName: "house", title: "Home", controller: home)
        let notifications = createViewController(tabBarItemImageName: "envelope", title: "Mailroom", controller: NotificationsTableVC())
        let profile = createViewController(tabBarItemImageName: "person", title: "Profile", controller: OtherProfileViewController())
        
        let homeNav = UINavigationController(rootViewController: home)
        let notigicationsNav = UINavigationController(rootViewController: notifications)
        let profileNav = UINavigationController(rootViewController: profile)
    
        self.viewControllers = [sidebar, newPost, homeNav, notigicationsNav, profileNav]
        self.selectedIndex = 2
    }
    ///creates tabbarItems and assigns them to the viewControllers
    private func createViewController(tabBarItemImageName: String, title: String, controller: UIViewController) -> UIViewController{
        let item = UITabBarItem()
        item.image = UIImage(systemName: tabBarItemImageName)?.withConfiguration(tabBarSymbolsConfiguration)
        item.title = title
        controller.tabBarItem = item
        return controller
    }
    private func setupNavigationBarAppearance(){
        UINavigationBar.appearance().tintColor = Constants.Colors.darkBrown
        UINavigationBar.appearance().barTintColor = Constants.Colors.mainYellow
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    private func setupTabBarAppearance(){
        //remove colors from tabbar
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        
        //create a rounded layer with shadow and add it to the transparent tabar
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: 0,
                                                      y: self.view.bounds.minY,
                                                      width: self.tabBar.bounds.width,
                                                      height: self.tabBar.bounds.height + 100),
                                  cornerRadius: (20)).cgPath
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowRadius = 25.0
        layer.shadowOpacity = 0.3
        layer.borderWidth = 1.0
        layer.opacity = 1.0
        layer.isHidden = false
        layer.masksToBounds = false
        layer.fillColor = UIColor.white.cgColor
        self.tabBar.layer.insertSublayer(layer, at: 0)

        //tabBar.barTintColor = Constants.backgroundColor
        //tabBar.unselectedItemTintColor = Constants.brownColor
        tabBar.tintColor = Constants.Colors.darkBrown//Constants.yellowColor
    }
}
//MARK: handling special cases of tabbar items
/// newPost and sidebar have special animation
/// if some menu options were selected they will be presented full screen.
/// if station options were selected tabbar selected item is set to 1
extension MainTabBarVC: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.isKind(of: NewPostVC.self){
            print("is loaded")
            
            let ac = UIAlertController(title: "Create A...", message: nil, preferredStyle: .actionSheet)
            //ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            ac.addAction(UIAlertAction(title: "New Post", style: .default, handler: newPostAction))
            ac.addAction(UIAlertAction(title: "New Mission", style: .default, handler: newMissionAction))
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
            present(ac, animated: true)
            
            return false
        }
        else if viewController.isKind(of: SidebarViewController.self){
            setupSideBarVC(tabBarController)
            return false
        }
        return true
    }
    func newPostAction(action: UIAlertAction) {
        setupNewPostVC(isMission: false)
    }
    func newMissionAction(action: UIAlertAction) {
        setupNewPostVC(isMission: true)
    }
    private func setupNewPostVC(isMission: Bool){
        let vc = NewPostVC()
        vc.isMission = isMission
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.isHidden = true
        navigationController.presentationController?.delegate = vc
        
        self.present(navigationController, animated: true)
    }
    private func setupSideBarVC(_ tabBarController: UITabBarController){
        let vc = SidebarViewController()
        vc.sideBarTransitionDelegate = home
        vc.transitioningDelegate = self
        vc.didTapSideBarMenuType = { menuType in
            self.transitionToNew(menuType)
        }
        vc.didTapSideBarStationType = { 
            tabBarController.selectedIndex = 2
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

