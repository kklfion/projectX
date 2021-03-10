//
//  Extensions.swift
//  projectX
//
//  Created by Radomyr Bezghin on 7/22/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    func addAnchors(top: NSLayoutYAxisAnchor?,
                leading:NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                trailing: NSLayoutXAxisAnchor?,
                padding: UIEdgeInsets = .zero,
                size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
}
extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
}

extension UIWindow {
    func topViewController() -> UIViewController? {
        var top = self.rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            } else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else {
                break
            }
        }
        return top
    }
}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

// Set text field icon with padding
extension UITextField {
    
    /// set icon of 20x20 with left padding of 8px
    func setLeftIcon(_ icon: UIImage, width: Int = 20, height: Int = 20) {
        
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: height) )
        let iconView  = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        iconView.image = icon
        outerView.addSubview(iconView)
        
        leftView = outerView
        leftView?.tintColor = Constants.Colors.darkBrown
        leftViewMode = .always
    }
}

// Used to convert hexcodes to UIcolor
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

extension UIViewController {
    // dismiss keyboard by tapping on page
    func addKeyboardTapOutGesture(target: Any)
    {
        let tapGesture = UITapGestureRecognizer(target: target, action: #selector(self.dismissKeyboard (_:)))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    func sidebarTapOutGesture(target: Any)
    {
        print("dismiss")
    }
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    func removeSublayer(withName: String,from: UIView, completion: () -> Void)
    {
        guard let sublayers = from.layer.sublayers
        else
        {
            return
        }
        for layer in sublayers {
             if layer.name == withName {
                  layer.removeFromSuperlayer()
                  completion()
             }
        }
    }
}
extension String {
func withBoldText(text: String, font: UIFont? = nil) -> NSAttributedString {
  let _font = font ?? UIFont.systemFont(ofSize: 14, weight: .regular)
  let fullString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: _font])
    let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: _font.pointSize), NSAttributedString.Key.foregroundColor: UIColor.black]
  let range = (self as NSString).range(of: text)
  fullString.addAttributes(boldFontAttribute, range: range)
  return fullString
}}
extension UIViewController{
    func add(_ child: UIViewController){
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
}
extension UIView {
    func applyShadowWithCorner(containerView : UIView, cornerRadious : CGFloat){
        containerView.clipsToBounds = false
        containerView.layer.shadowColor = UIColor.gray.cgColor
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowOffset = CGSize(width: 0.0, height: -5)
        containerView.layer.shadowRadius = 3
        containerView.layer.cornerRadius = cornerRadious
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: cornerRadious).cgPath
        self.layer.cornerRadius = cornerRadious
    }
}
extension Date {
 // Function in which calculates the time past since a post and returns time as a string
 func diff() -> String {
    
 // Timestamp of post
 let date = self
    
 // To find the difference, we need the current time
 let currentTime = Date()
    
 // Utilize components from Calender structure to calculate various units of time
 let second = Calendar.current.dateComponents([.second], from: date, to: currentTime).second
 let minute = Calendar.current.dateComponents([.minute], from: date, to: currentTime).minute
 let hour = Calendar.current.dateComponents([.hour], from: date, to: currentTime).hour
 let day = Calendar.current.dateComponents([.day], from: date, to: currentTime).day
 let year = Calendar.current.dateComponents([.year], from: date, to: currentTime).year
    
 // Display message depending on time difference
 if year != 0 {
    return String(year ?? 0) + "y"
 }
 if day != 0 {
    return String(day ?? 0) + "d"
 }
 if hour != 0 {
    return String(hour ?? 0) + "h"
 }
 if minute != 0 {
    return String(minute ?? 0) + "m"
 }
 if second != 0 {
    return String(second ?? 0) + "s"
 }
 return "0s"
 }
}

extension UINavigationController{
    func setNavigationToViewColor(){
        // Restore the navigation bar to default
        self.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.barTintColor = Constants.Colors.mainBackground
        self.navigationBar.isTranslucent = true
    }
    func setNavigationToTransparent(){
        // Make the navigation bar background clear
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
    }
    func setNavigationTo(color: UIColor){
        // Restore the navigation bar to default
        self.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationBar.barTintColor = color
        self.navigationBar.shadowImage = UIImage()
    }
    func setNavigationTo(colorStringHex: String){
        let color = UIColor().hexStringToUIColor(hex: colorStringHex)
        // Restore the navigation bar to default
        self.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationBar.barTintColor = color
        self.navigationBar.shadowImage = UIImage()
    }
}
extension UIColor {
    public convenience init?(hex: String, alpha: CGFloat = 1) {
        let r, g, b: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255

                    self.init(red: r, green: g, blue: b, alpha: alpha)
                    return
                }
            }
        }
        return nil
    }
}
