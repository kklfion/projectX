//
//  RoundedNavBarProtocol.swift
//  projectX
//
//  Created by Radomyr Bezghin on 12/1/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

protocol RoundedCornerNavigationBar {
    func addRoundedCorner(OnNavigationBar navigationBar: UINavigationBar, cornerRadius: CGFloat)
}
extension RoundedCornerNavigationBar where Self: UIViewController{
    
    func addRoundedCorner(OnNavigationBar navigationBar: UINavigationBar, cornerRadius: CGFloat){
        navigationBar.isTranslucent = false
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.backgroundColor = .white
        
        let customView = UIView(frame: CGRect(x: 0, y: navigationBar.bounds.maxY, width: navigationBar.bounds.width, height: cornerRadius))
        customView.backgroundColor = .clear
        navigationBar.insertSubview(customView, at: 1)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: customView.bounds, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        
        shapeLayer.shadowColor = UIColor.lightGray.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: 4.0)
        shapeLayer.shadowOpacity = 0.2
        shapeLayer.shadowRadius = 2
        shapeLayer.fillColor = Constants.yellowColor.cgColor
        customView.layer.insertSublayer(shapeLayer, at: 0)
    }
}

protocol RoundedCornerTabBar {
    func addRoundedCorner(OnTabBar tabBar: UITabBar, cornerRadius: CGFloat)
}
extension RoundedCornerNavigationBar where Self: UIViewController{
    
    func addRoundedCorner(OnTabBar tabBar: UITabBar, cornerRadius: CGFloat){
        tabBar.isTranslucent = false
        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = .white
        
        let customView = UIView(frame: CGRect(x: 0, y: tabBar.bounds.maxY, width: tabBar.bounds.width, height: cornerRadius))
        customView.backgroundColor = .clear
        tabBar.insertSubview(customView, at: 1)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: customView.bounds, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        
        shapeLayer.shadowColor = UIColor.lightGray.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: 4.0)
        shapeLayer.shadowOpacity = 0.2
        shapeLayer.shadowRadius = 2
        shapeLayer.fillColor = Constants.yellowColor.cgColor
        customView.layer.insertSublayer(shapeLayer, at: 0)
    }
}
