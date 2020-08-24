//
//  MainContainerVC.swift
//  projectX
//
//  Created by Radomyr Bezghin on 6/16/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

class MainContainerVC: UIViewController {
    // MARK: - variables
    var sideBarMenu: SidebarVC!
    var tabbar: MainTabBarVC!
    let ConstantVals = ConstantValues()
    var shouldMenuSlideOut = true
    
    
    // MARK: - viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainTabBarVC()
    }
    // MARK: - configure child VCs
    func configureSideBarVC(){
        if(sideBarMenu == nil){
            //setup menu
            sideBarMenu = SidebarVC()
            let nav = UINavigationController(rootViewController: sideBarMenu)
            nav.navigationBar.isHidden = true
            view.insertSubview(nav.view, at: 0)
            addChild(nav)
            nav.didMove(toParent: self)
        }
    }
    func configureMainTabBarVC(){
        tabbar = MainTabBarVC()
        tabbar.tabBarDelegate = self
        view.addSubview(tabbar.view)
        addChild(tabbar)
        tabbar.didMove(toParent: self)
        
    }
    func performAnimation(){
        UIView.animate(withDuration: ConstantVals.animationDuration, delay: 0, usingSpringWithDamping: ConstantVals.springDamping, initialSpringVelocity: 0, options: .curveEaseOut,
            animations:
            {
                if(self.shouldMenuSlideOut){
                    
                    self.tabbar.view.frame.origin.x = self.tabbar.view.frame.width - self.ConstantVals.slideOutChange
                } else{
                    self.tabbar.view.frame.origin.x = 0
                }
                self.shouldMenuSlideOut.toggle()
        }, completion: nil)
    }
}

extension MainContainerVC: TabBarSideBarDelegate{
    //called from tabbarVC when menu button is clicked
    func handleMenuToggle() {
        configureSideBarVC()
        performAnimation()
    }
}
struct ConstantValues {
    let animationDuration = 0.5
    let springDamping: CGFloat = 0.8
    let slideOutChange: CGFloat = 150.0
}
