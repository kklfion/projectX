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
    
    static let mainBlue = UIColor.rgb(red: 0, green: 150, blue: 255)
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

extension Date {
    
  // Function in which calculates the time past on a particular post and returns
  // this time as a string
  func diff(date: Date) -> String {
      
  // To find the difference in time, we need make a variable to represent the current day
  let today = Date()
    
  // Here, we extract components from the Calender structure in which will help us
  // calculate various units of time
  let second = Calendar.current.dateComponents([.second], from: date, to: today).second
  let minute = Calendar.current.dateComponents([.minute], from: date, to: today).minute
  let hour = Calendar.current.dateComponents([.hour], from: date, to: today).hour
  let day = Calendar.current.dateComponents([.day], from: date, to: today).day
  let month = Calendar.current.dateComponents([.month], from: date, to: today).month
  let year = Calendar.current.dateComponents([.year], from: date, to: today).year
    
  // In order to display the message, we use nested if statements to check how much time
  // has past to ensure we return the correct amount of time
  if year == 0 {
     if month == 0 {
         if day == 0 {
             if hour == 0 {
                 if minute == 0 {
                     if second == 0 {
                      return "0 seconds ago"
                      }
                  return String(second!) + " seconds ago"
                  }
              return String(minute!) + " minutes ago"
              }
          return String(hour!) + " hours ago"
          }
      return String(day!) + " days ago"
      }
     return String(month!) + " months ago"
     }
  return String(year!) + " years ago"
  }
}
