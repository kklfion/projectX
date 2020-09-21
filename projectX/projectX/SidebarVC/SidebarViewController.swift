//
//  SidebarVC.swift
//  projectX
//
//  Created by Radomyr Bezghin on 6/15/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit
enum SideBarMenuType{
    case match
    case friends
    case settings
}
extension SidebarViewController{
    @objc private func didTapDissmissSidebar(){
        self.dismiss(animated: true)
    }
    @objc func didTapSettingsButton(){
        self.dismiss(animated: true) { [weak self] in
            self?.didTapSideBarMenuType?(SideBarMenuType.settings)
        }
    }
    private func setupCancelButton(){
        view.addSubview(cancelButton)
        cancelButton.addAnchors(top: view.safeAreaLayoutGuide.topAnchor,
                                leading: view.safeAreaLayoutGuide.leadingAnchor,
                                bottom: nil,
                                trailing: nil,
                                padding: .init(top: 10, left: 10, bottom: 0, right: 0))
    }
}
class SidebarViewController: UIViewController {
    var scrollView: UIScrollView!
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(didTapDissmissSidebar), for: .touchUpInside)
        return button
    }()
    var didTapSideBarMenuType: ((SideBarMenuType) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCancelButton()
        
        view.backgroundColor = .white
        
        //In future I will further condense code by using for loop for the hardcoded buttons (match, friends, setting, etc...) to make it simple and easy to read
        
        //                          UI Labels
        let label = UILabel(frame: CGRect(x: 0, y: 50, width:UIScreen.main.bounds.size.width-20.0, height: 35))
              label.center = CGPoint(x: 120, y: 80)
              label.textAlignment = .center
              label.text = "Stations"
              label.font = UIFont.systemFont(ofSize: 30)
              label.font = UIFont (name: "ChalkboardSE-Regular" , size: 30) // Delete if custom font
              self.view.addSubview(label)
        
        //                          UI Buttons
        // Bottom
        let Button = UIButton(type: .system)
        Button.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - 100, width: 200, height: 25)
        Button.setTitle("Settings", for: .normal)
        Button.center = CGPoint(x: 120, y: UIScreen.main.bounds.size.height - 50)
        Button.tintColor = UIColor.black
        Button.backgroundColor = UIColor.white
        Button.titleLabel?.font = .systemFont(ofSize: 22)
        Button.titleLabel?.font =  UIFont(name: "ChalkboardSE-Regular", size: 22)
        Button.contentHorizontalAlignment = .left
        Button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 0 )
        Button.sizeToFit()
        Button.addTarget(self, action: #selector(didTapSettingsButton), for: .touchUpInside)
        self.view.addSubview(Button)
        
        //Setting image
        let myImage:UIImage = UIImage(named: "settings.png")!
        let myImageView:UIImageView = UIImageView()
        myImageView.image = UIImage(systemName: "gearshape")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        myImageView.frame = CGRect(x:35,y:UIScreen.main.bounds.size.height - 67,width:20,height:20)
       self.view.addSubview(myImageView)
        
        
        
        
        
        
        let Button1 = UIButton(type: .system)
        Button1.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - 100, width: 200, height: 25)
        Button1.setTitle("Night Mode", for: .normal)
        Button1.center = CGPoint(x: 120, y: UIScreen.main.bounds.size.height - 90)
        Button1.tintColor = UIColor.black
        Button1.backgroundColor = UIColor.white
        Button1.titleLabel?.font = .systemFont(ofSize: 22)
        Button1.titleLabel?.font =  UIFont(name: "ChalkboardSE-Regular", size: 22)
        Button1.contentHorizontalAlignment = .left
        Button1.contentEdgeInsets = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 0)
        Button1.sizeToFit()
        self.view.addSubview(Button1)
        
        //Nightmode image
        let myImage1:UIImage = UIImage(named: "nightmode.png")!
        let myImageView1:UIImageView = UIImageView()
        myImageView1.image = UIImage(systemName: "moon.stars")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        myImageView1.frame = CGRect(x:35,y:UIScreen.main.bounds.size.height - 107,width:20,height:20)
        self.view.addSubview(myImageView1)
        
        
        
        
        
        
        
        let Button2 = UIButton(type: .system)
        Button2.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - 100, width: 200, height: 25)
        Button2.setTitle("Library", for: .normal)
        Button2.center = CGPoint(x: 120, y: UIScreen.main.bounds.size.height - 130)
        Button2.tintColor = UIColor.black
        Button2.backgroundColor = UIColor.white
        Button2.titleLabel?.font = .systemFont(ofSize: 22)
        Button2.titleLabel?.font =  UIFont(name: "ChalkboardSE-Regular", size: 22)
        Button2.contentHorizontalAlignment = .left
        Button2.contentEdgeInsets = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 0)
        Button2.sizeToFit()
        self.view.addSubview(Button2)
        
        //Library image
        let myImage2:UIImage = UIImage(named: "library.png")!
        let myImageView2:UIImageView = UIImageView()
        myImageView2.image = UIImage(systemName: "book")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        myImageView2.frame = CGRect(x:35,y:UIScreen.main.bounds.size.height - 147,width:20,height:20)
        self.view.addSubview(myImageView2)
        
        
        
        
        let Button3 = UIButton(type: .system)
        Button3.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - 100, width: 200, height: 25)
        Button3.setTitle("Friends", for: .normal)
        Button3.center = CGPoint(x: 120, y: UIScreen.main.bounds.size.height - 170)
        Button3.tintColor = UIColor.black
        Button3.backgroundColor = UIColor.white
        Button3.titleLabel?.font = .systemFont(ofSize: 25)
        Button3.titleLabel?.font =  UIFont(name: "ChalkboardSE-Regular", size: 25)
        Button3.contentHorizontalAlignment = .left
        Button3.contentEdgeInsets = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 0)
        Button3.sizeToFit()
        self.view.addSubview(Button3)
        
        //friends image
        let myImage3:UIImage = UIImage(named: "people.png")!
        let myImageView3:UIImageView = UIImageView()
        myImageView3.image = UIImage(systemName: "person.2")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        myImageView3.frame = CGRect(x:35,y:UIScreen.main.bounds.size.height - 187,width:20,height:20)
        self.view.addSubview(myImageView3)
               
               
        
        
        
        
        
        let Button4 = UIButton(type: .system)
        Button4.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - 100, width: 200, height: 25)
        Button4.setTitle("Match", for: .normal)
        Button4.center = CGPoint(x: 120, y: UIScreen.main.bounds.size.height - 210)
        Button4.tintColor = UIColor.black
        Button4.backgroundColor = UIColor.white
        Button4.titleLabel?.font = .systemFont(ofSize: 25)
        Button4.titleLabel?.font =  UIFont(name: "ChalkboardSE-Regular", size: 25)
        Button4.contentHorizontalAlignment = .left
        Button4.contentEdgeInsets = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 0)
        Button4.sizeToFit()
        self.view.addSubview(Button4)
        
        //match image
        let myImage4 = UIImage(systemName: "heart")
        let myImageView4:UIImageView = UIImageView()
        myImageView4.image = UIImage(systemName: "heart")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        myImageView4.frame = CGRect(x:35,y:UIScreen.main.bounds.size.height - 227,width:20,height:20)
        self.view.addSubview(myImageView4)
        
        
        
        //                          UI ScrollView
        
        
        
        scrollView = UIScrollView(frame: CGRect(x: 5, y: 110, width:view.frame.width - 100 , height: 320))
        scrollView.backgroundColor = .white
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: UIScreen.main.bounds.height+50)
        
        //scrollView.layer.borderWidth = 0.4
        //scrollView.layer.borderColor = (UIColor( red: 0, green: 0, blue:0, alpha: 1.0 )).cgColor
        //uncomment above code if border is needed, I was confused with the sketch.
        scrollView.delaysContentTouches = false
        view.addSubview(scrollView)
        
        let mybuttonnames = ["Travel", "Art", "Drama", "Gaming", "Meme", "Makeup", "Politics", "Music", "Sports", "Food", "Abroad", "Writing", "Development", "Financial", "Pets", "Job", "Astrology", "Horror", "Anime", "LGBTQ+", "Film", "Relationship", "Photography", "International"
        
        ]
        var vertDist =  15
        var prevVertDist = vertDist
        var alternate = 0
        for i in 0...mybuttonnames.count - 1 {
            let Button5 = UIButton(type: .system)
            let name = mybuttonnames[i]
            Button5.setTitle(name, for: .normal)
            //We need to adjust the frame according to the size of the text
            let font = UIFont(name: "ChalkboardSE-Regular", size: 15)
            let fontAttributes = [NSAttributedString.Key.font: font]
            let width = (Button5.currentTitle! as String).size(withAttributes: fontAttributes as [NSAttributedString.Key : Any]).width
            
            Button5.frame = CGRect(x:0, y:vertDist, width: Int(width), height: 15)
            
            var xPos = 0
            var yPos = 0
            let centerX = Int(scrollView.center.x) - 30
            if (width < 75) {
                xPos = (alternate % 2) * (centerX + 50) + ((alternate+1) % 2) * (centerX - 50)
                yPos = (alternate % 2) * prevVertDist + ((alternate+1) % 2) * vertDist
                alternate = (alternate + 1) % 2
            } else {
                xPos = centerX
                yPos = vertDist
                vertDist += 17
            }
            prevVertDist = vertDist
            vertDist += 17
            
            Button5.center = CGPoint(x: xPos, y: yPos)
            
            Button5.tintColor = UIColor.black
            Button5.backgroundColor = UIColor.white
            Button5.titleLabel?.font = .systemFont(ofSize: 15)
            Button5.titleLabel?.font =  UIFont(name: "ChalkboardSE-Regular", size: 15)
            Button5.contentHorizontalAlignment = .center
            Button5.sizeToFit()
            self.scrollView.addSubview(Button5)
        }
        
        //in future, add button action in for loop and create conditions that checks name of button when clicked, then redirect them to that certain page I believe
        
        
        //                          Notes
        // https://developer.apple.com/documentation/uikit/uiscrollview/1619398-delayscontenttouches
        // above link helped me fix an issue of uibutton not working in scrollview
        // https://stackoverflow.com/questions/16649639/uibutton-does-not-work-when-it-in-uiscrollview
        // This helped me figure out why it was not recognizing uibutton
        
        // https://stackoverflow.com/questions/4135032/ios-uibutton-resize-according-to-text-length
        // This helped with button fram auto layout

    }
}

