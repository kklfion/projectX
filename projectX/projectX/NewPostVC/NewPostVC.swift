//
//  NewPostViewController.swift
//  projectX
//
//  Created by Radomyr Bezghin on 6/15/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

class NewPostVC: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    

    //let texFiel = UITextField()
   
    @IBOutlet weak var titlepost: UITextField!  //
    @IBOutlet weak var titlepost1: UITextField!  //
    
    @IBOutlet weak var pickerview: UIPickerView!
    //@IBOutlet weak var label1:UILabel!
    //@IBOutlet weak var textField: UITextField!
    
    
    
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
        
        //                                       Channel display
        // let label1 = UILabel(frame: CGRect(x: 10, y: 100, width:UIScreen.main.bounds.size.width - 20.0, height: 35))
       // label1.textAlignment = .center
        
     //   label1.font = UIFont (name: "ChalkboardSE-Regular" , size: 15) // Delete if custom font
      //  self.view.addSubview(label1)
        
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
        chooseChannel.addTarget(self, action: #selector(channelAction), for: .touchUpInside)
        self.view.addSubview(chooseChannel)
        
        //                                       X(CANCEL)BUTTON
        
        let Xbutton = UIButton(type: .system)
        Xbutton.frame = CGRect(x: 1, y: 10, width: 40, height: 40)
        Xbutton.setTitle("X", for: .normal)
        Xbutton.tintColor = UIColor.black
        Xbutton.backgroundColor = UIColor.white
        Xbutton.titleLabel?.font = .systemFont(ofSize: 18)
        Xbutton.titleLabel?.font =  UIFont(name: "ChalkboardSE-Regular", size: 18) // Delete if custom font
        Xbutton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(Xbutton)
        
        //                                       POST BUTTON
        
        let postButton = UIButton(type: .system)
        postButton.frame = CGRect(x: UIScreen.main.bounds.size.width - 50.0, y: 10, width: 40, height: 40)
        postButton.setTitle("Post", for: .normal)
        postButton.tintColor = UIColor.black
        postButton.backgroundColor = UIColor.white
        postButton.titleLabel?.font = .systemFont(ofSize: 18)
        postButton.titleLabel?.font =  UIFont(name: "ChalkboardSE-Regular", size: 18) // Delete if custom font
        postButton.addTarget(self, action: #selector(postAction), for: .touchUpInside)
        self.view.addSubview(postButton)
        
        
        
        
        
        
       
         
        
        
        
        
        
        
        //---------------------------------------------------------------------------------------------------------
        
        
        //                                       Notes
        //  Link provides way to use View UI for horizontal borders, getting rid of right and left borders of choose channel
        //  https://stackoverflow.com/questions/40030143/how-to-remove-right-and-left-borders-in-uibutton
        //  Fonts here http://iosfonts.com/
        //  Touching outside textfield
        //https://stackoverflow.com/questions/32281651/how-to-dismiss-keyboard-when-touching-anywhere-outside-uitextfield-in-swift
        //Ui button: https://www.appsdeveloperblog.com/create-uibutton-in-swift-programmatically/
        //picker https://stackoverflow.com/questions/53774232/show-a-uipickerview-when-a-button-is-tapped
        
    }
    
    
      
         
    // CHANNEL PICKER VIEW
    let channels1 = ["Games", "Social", "Hello", "Gurpreet", "Test"]
    var selectedchannel = String()
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return channels1[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return channels1.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedchannel = channels1[row]
    }
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    var label1 = UILabel()
    var counter = 1
    @IBAction func channelAction(sender: UIButton!) {
     picker = UIPickerView.init()
     picker.delegate = self
     picker.backgroundColor = UIColor.white
     picker.setValue(UIColor.black, forKey: "textColor")
     picker.autoresizingMask = .flexibleWidth
     picker.contentMode = .center
     picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
     self.view.addSubview(picker)
     toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 35))
     toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(doneButton))]
     self.view.addSubview(toolBar)
    }
    @objc func doneButton() {
     toolBar.removeFromSuperview()
     picker.removeFromSuperview()
     if counter == 1{
      label1 = UILabel(frame: CGRect(x: 10, y: 155, width:UIScreen.main.bounds.size.width - 20.0, height: 40))
      label1.font = UIFont (name: "ChalkboardSE-Regular" , size: 15) // Delete if custom font
      label1.textAlignment = .center
      label1.font = UIFont (name: "ChalkboardSE-Regular" , size: 15) // Delete if custom font
      label1.text = selectedchannel
      self.view.addSubview(label1)
      counter += 1
        }
     else {
      label1.text = selectedchannel
        }
    }
    // END OF CHANNEL PICKER VIEW
    
    
    
    
    
    
    // How to exit textfield, clicking away
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Function for setting return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // cancel button
    @objc func buttonAction(_ sender:UIButton!) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    // post button
     @IBAction func postAction(sender: UIButton!) {
        
        // let nextVC = HomeTableVC()
         //nextVC.stringHolder = titlepost1.text! + titlepost.text!
        
        //let nextVC = HomeTableVC()
        //nextVC.stringHolder = channels1[row]
        //navigationController?.pushViewController(nextVC, animated: true)
        
                      //self.present(HomeTableVC, animated: true, completion: nil)
        //navigationController?.pushViewController(HomeTableVC, animated: true)
    }
    
}

