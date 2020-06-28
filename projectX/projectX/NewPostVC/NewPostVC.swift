//
//  NewPostViewController.swift
//  projectX
//
//  Created by Radomyr Bezghin on 6/15/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

class NewPostVC: UIViewController, UITextFieldDelegate {

    //let texFiel = UITextField()
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        
        
        
        //                                     UI Textfields
        
        //---------------------------------------------------------------------------------------------------------
        //                                     Title
        
        let titlepost = UITextField(frame: CGRect(x: 10.0, y: 200.0, width:UIScreen.main.bounds.size.width - 20.0 , height: 50.0))
        titlepost.backgroundColor = .white
        //titlepost.borderStyle = .line
        //titlepost.placeholder = "Title"
        titlepost.attributedPlaceholder = NSAttributedString(string: "Title", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        titlepost.font = UIFont.systemFont(ofSize: 20.0)
        titlepost.font = UIFont (name: "ChalkboardSE-Regular" , size: 20.0) // Delete if custom font
        titlepost.tintColor = UIColor.black
        titlepost.delegate = self
        self.view.addSubview(titlepost)
    
        //                                      Enter your thoughts
        
        let titlepost1 = UITextField(frame: CGRect(x: 10.0, y: 255.0, width:UIScreen.main.bounds.size.width - 20.0 , height: 280.0))
        self.view.addSubview(titlepost1)
        titlepost1.backgroundColor = .white
        titlepost1.delegate = self
        titlepost1.font = UIFont.systemFont(ofSize: 15.0)
        titlepost1.font = UIFont (name: "ChalkboardSE-Regular" , size: 15) // Delete if custom font
        //titlepost1.placeholder = "Enter your thoughts"
        titlepost1.attributedPlaceholder = NSAttributedString(string: "Enter your thoughts", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        titlepost1.tintColor = UIColor.black
        titlepost1.textAlignment = .left
        titlepost1.contentVerticalAlignment = .top
        
        //---------------------------------------------------------------------------------------------------------
        
        
        
        
        
        //                                       UI VIEW
        
        //---------------------------------------------------------------------------------------------------------
        //                                       New Post
        
        let label = UILabel(frame: CGRect(x: 10, y: 50, width:UIScreen.main.bounds.size.width - 20.0, height: 35))
        //label.center = CGPoint(x: 50, y: 50)
        label.textAlignment = .center
        label.text = "New Post"
        label.font = UIFont.systemFont(ofSize: 30)
        label.font = UIFont (name: "ChalkboardSE-Regular" , size: 30) // Delete if custom font
        self.view.addSubview(label)
        
        //---------------------------------------------------------------------------------------------------------
        
        
        
        
        
        //                                       UI BUTTONS
        
        //---------------------------------------------------------------------------------------------------------
        //                                       ChooseChannel
        
        let chooseChannel = UIButton(type: .system)
        chooseChannel.frame = CGRect(x: 0.0, y: 155.0, width: UIScreen.main.bounds.size.width, height: 40)
        chooseChannel.setTitle("  Choose Channel >", for: .normal)
        chooseChannel.contentHorizontalAlignment = .left
        chooseChannel.tintColor = UIColor.black
        chooseChannel.backgroundColor = UIColor.white
        chooseChannel.layer.borderWidth = 0.4
        chooseChannel.layer.borderColor = (UIColor( red: 0, green: 0, blue:0, alpha: 1.0 )).cgColor
        chooseChannel.titleLabel?.font =  UIFont(name: "ChalkboardSE-Regular", size: 15) // Delete if custom font
        self.view.addSubview(chooseChannel)
        
        //                                       X(CANCEL)BUTTON
        
        let Xbutton = UIButton(type: .system)
        Xbutton.frame = CGRect(x: 1, y: 10, width: 40, height: 40)
        Xbutton.setTitle("X", for: .normal)
        Xbutton.tintColor = UIColor.black
        Xbutton.backgroundColor = UIColor.white
        Xbutton.titleLabel?.font = .systemFont(ofSize: 18)
        Xbutton.titleLabel?.font =  UIFont(name: "ChalkboardSE-Regular", size: 18) // Delete if custom font
        self.view.addSubview(Xbutton)
        
        //                                       POST BUTTON
        
        let postButton = UIButton(type: .system)
        postButton.frame = CGRect(x: UIScreen.main.bounds.size.width - 50.0, y: 10, width: 40, height: 40)
        postButton.setTitle("Post", for: .normal)
        postButton.tintColor = UIColor.black
        postButton.backgroundColor = UIColor.white
        postButton.titleLabel?.font = .systemFont(ofSize: 18)
        postButton.titleLabel?.font =  UIFont(name: "ChalkboardSE-Regular", size: 18) // Delete if custom font
        self.view.addSubview(postButton)
        
        //---------------------------------------------------------------------------------------------------------
        
        
        //                                       Notes
        //  Link provides way to use View UI for horizontal borders, getting rid of right and left borders of choose channel
        //  https://stackoverflow.com/questions/40030143/how-to-remove-right-and-left-borders-in-uibutton
        //  Fonts here http://iosfonts.com/
        //  Touching outside textfield
        //https://stackoverflow.com/questions/32281651/how-to-dismiss-keyboard-when-touching-anywhere-outside-uitextfield-in-swift
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Function for setting return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//extension ViewController : UITextFieldDelegate {
 //   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
 //       textField.resignFirstResponder()
  //      return true
//    }
    
//}
