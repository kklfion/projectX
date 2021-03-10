//
//  SlidableProtocol.swift
//  projectX
//
//  Created by Radomyr Bezghin on 2/16/21.
//  Copyright © 2021 Radomyr Bezghin. All rights reserved.
//

import UIKit

protocol SlidableTopViewProtocol: class{
    ///hide of the header to hide when scrolling
    var headerHeight: CGFloat? { get set }
    
    ///must be pinned to the top anchor of the view that is sliding
    var headerTopConstraint: NSLayoutConstraint! { get set }
    
    ///adjusts header position and hides/unhides navigationbar
    func adjustHeaderPosition(_ scrollView: UIScrollView,_ controller: UINavigationController?, navigationItem: UINavigationItem?, _ title: String?, _ color: String?)
    
    ///to setup headerHeight provide its height and additional padding if header wasnt pinned to the safearea
    func setupHeaderHeight(header height: CGFloat, safeArea padding: CGFloat)
    
    ///once it was set we dont want to change it
    func headerHeightWasSet() -> Bool
    
}
extension SlidableTopViewProtocol{
    func setupHeaderHeight(header height: CGFloat, safeArea padding: CGFloat){
        self.headerHeight =  height - padding //header height minus the extra space that will be covered under the navbar
    }
    func headerHeightWasSet() -> Bool{
        return headerHeight != nil
    }
    func adjustHeaderPosition(_ scrollView: UIScrollView,_ controller: UINavigationController?, navigationItem: UINavigationItem?, _ title: String? = nil, _ color: String? = nil){
        guard let headerHeight = headerHeight else {return}
        let y_offset: CGFloat = scrollView.contentOffset.y
        let headerOffset = headerTopConstraint.constant - y_offset
        if isAboveHeader(headerHeight: headerHeight, currentOffset: headerOffset){
            headerTopConstraint.constant = -headerHeight //dont move past that point
        } else if headerOffset >= 0{//when scrolling down remain at 0
            headerTopConstraint.constant = 0
            controller?.setNavigationToTransparent()
            navigationItem?.title = ""
        }else{//inbetween we want to adjust the position of the header
            navigationItem?.title = title
            if let color = color {
                controller?.setNavigationTo(colorStringHex: color)
            } else {
                controller?.setNavigationToViewColor()
            }
            headerTopConstraint.constant = headerOffset
            scrollView.contentOffset.y = 0 //to smooth out scrolling
        }
    }
    func isAboveHeader(headerHeight: CGFloat, currentOffset:CGFloat) -> Bool{
        return currentOffset <= -headerHeight
    }
}
