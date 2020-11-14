//  NewPostViewController.swift
//  projectX
//
//  Created by Radomyr Bezghin on 6/15/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//
import Photos
import AVFoundation
import UIKit
import Firebase
import FirebaseFirestore
import FirebaseUI

let button = UIButton()
var myTxtview = UITextView()
var titlepost = UITextField()
var postData = [String: Any]()
var postData1 = [String: Any]()
var switchbar = UISwitch()
var pickerview = UIPickerView()
var Anonymity = false
var success = "No Errors"
var postImage = UIImage()
var label1 = UILabel()
var imagePreview = UIImageView()
var imageCancel = UIButton()

class NewPostVC: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate,
UIImagePickerControllerDelegate, UINavigationControllerDelegate, UNUserNotificationCenterDelegate
{

    override func viewDidLoad() {
       
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        
        
        imagePreview.frame = CGRect(x: 25.0, y: 160.0, width:UIScreen.main.bounds.size.width - 50.0 , height: 300)
        imagePreview.layer.borderColor = UIColor.black.cgColor
        imagePreview.layer.borderWidth = 2.6
        //                                     UI Textfields
        
        //---------------------------------------------------------------------------------------------------------
        //                                     Title
        titlepost = UITextField(frame: CGRect(x: 10.0, y: 95.0, width:UIScreen.main.bounds.size.width - 20.0 , height: 50.0))//was 200
        titlepost.backgroundColor = .white
        titlepost.attributedPlaceholder = NSAttributedString(string: "Title", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        titlepost.font = UIFont.systemFont(ofSize: 20.0)
        titlepost.font = UIFont (name: "ChalkboardSE-Regular" , size: 20.0)
        titlepost.tintColor = UIColor.black
        titlepost.delegate = self
        //titlepost.autocorrectionType = .yes
        self.view.addSubview(titlepost)
    
         
       // myTxtview.autocorrectionType = .yes
        myTxtview.isScrollEnabled = true
        myTxtview.frame = CGRect(x: 10.0, y: 150.0, width:UIScreen.main.bounds.size.width - 20.0 , height: 400.0)
        NotificationCenter.default.addObserver(self, selector: #selector(didShow), name: UIResponder.keyboardDidShowNotification, object: nil)
              
        NotificationCenter.default.addObserver(self, selector: #selector(didHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        myTxtview.backgroundColor = .white
        myTxtview.delegate = self
        myTxtview.font = UIFont (name: "ChalkboardSE-Regular" , size: 13.5)
       myTxtview.tintColor = UIColor.black
        myTxtview.textAlignment = .left
        myTxtview.text = "Enter your thoughts here..."
        myTxtview.textColor = .black
        
        self.view.addSubview(myTxtview)

        
       //                           REFINED TOOLBAR CODE
        
       // Toolbar
        let tool = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        tool.backgroundColor = .white
         let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let fixSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixSpace.width = 12
        let fixSpace1 = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixSpace1.width = 12
      
        // SWITCH UI

       // let switchbar = UISwitch()
        switchbar.frame = CGRect(x: 0, y: 5, width: 23, height: 23)
        let ButtonView = UIView(frame: switchbar.frame)
        switchbar.sizeToFit()
        switchbar.isOn = true
        switchbar.setOn(true, animated: false)
        switchbar.addTarget(self, action: #selector(switch2(_:)), for: .valueChanged)
        ButtonView.sizeToFit()
        ButtonView.addSubview(switchbar)
        
        // PROFILE PIC, ANON IN FUNCTION CALL
        button.frame = CGRect(x: 0, y: -1, width: 23, height: 23)
        let suggestButtonContainer = UIView(frame: button.frame)
        button.sizeToFit()
        button.setImage(UIImage(named: "sluglogoo.png"), for: .normal)
        suggestButtonContainer.sizeToFit()
        suggestButtonContainer.addSubview(button)
        
        // GALLERY BUTTON
        let button1 = UIButton()
        button1.frame = CGRect(x: 0, y: -1.2, width: 23, height: 23)
        let suggestButtonContainer1 = UIView(frame: button1.frame)
        
        // DELETE sizeToFit for the buttons, its screwing everything up, maybe keep?
        
        button1.sizeToFit()
        button1.setImage(UIImage(named: "sluglogoo.png"), for: .normal)
        button1.addTarget(self, action: #selector(loadPhotoTapped), for: .touchUpInside)
        suggestButtonContainer1.sizeToFit()
        suggestButtonContainer1.addSubview(button1)
        
        //PAPERCLIP BUTTON IMAGE   --> Now new post
        let button2 = UIButton()
        button2.frame = CGRect(x: 0, y: -1, width: 23, height: 23)
        let suggestButtonContainer2 = UIView(frame: button2.frame)
        button2.sizeToFit()
        button2.setImage(UIImage(named: "newpost.png"), for: .normal)
        button2.addTarget(self, action: #selector(postAction), for: .touchUpInside)
        suggestButtonContainer2.sizeToFit()
        suggestButtonContainer2.addSubview(button2)
        
        
        let barButton = UIBarButtonItem()
        barButton.customView = suggestButtonContainer
        
        let barButton1 = UIBarButtonItem()
        barButton1.customView = suggestButtonContainer1
        
        let barButton2 = UIBarButtonItem()
        barButton2.customView = suggestButtonContainer2
        
        let barSwitch = UIBarButtonItem()
        barSwitch.customView = ButtonView
        
        
        tool.barTintColor = .white
        tool.isTranslucent = false
        tool.clipsToBounds = true
        tool.setItems([fixSpace1, barButton, fixSpace, barSwitch, flexSpace, barButton1,fixSpace, barButton2, fixSpace1] , animated: true)
        tool.sizeToFit()
        titlepost.inputAccessoryView = tool
        myTxtview.inputAccessoryView = tool
        
        
        
        
        
        
        
        
        
        
        
        
        //                                       UI VIEW
        
        //---------------------------------------------------------------------------------------------------------
        //                                       New Post
        
        let label = UILabel(frame: CGRect(x: 10, y: 10, width:UIScreen.main.bounds.size.width - 20.0, height: 35))
        //label.center = CGPoint(x: 50, y: 50)
        label.textAlignment = .center
        label.text = "New Post"
        label.font = UIFont.systemFont(ofSize: 30)
        label.font = UIFont (name: "ChalkboardSE-Regular" , size: 30)
        self.view.addSubview(label)
                
        
        
        
        //                                       UI BUTTONS
        
        //---------------------------------------------------------------------------------------------------------
        //                                       ChooseChannel
        
        
        imageCancel.frame = CGRect(x: 18.0, y: 153.5, width: 15, height: 15)
        imageCancel.setTitle("X", for: .normal)
        //imageCancel.setTitleColor(UIColor.black, for: .normal)
        imageCancel.layer.borderWidth = 1
        imageCancel.layer.cornerRadius = 7
        imageCancel.backgroundColor = .black
        imageCancel.layer.borderColor = UIColor.black.cgColor
        imageCancel.addTarget(self, action: #selector(cancelingimage), for: .touchUpInside)
        
        
        
        let chooseChannel = UIButton(type: .system)
        chooseChannel.frame = CGRect(x: 0.0, y: 55.0, width: UIScreen.main.bounds.size.width, height: 40) //was 155
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
        Xbutton.titleLabel?.font =  UIFont(name: "ChalkboardSE-Regular", size: 18)
        Xbutton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(Xbutton)
        
        //                                       POST BUTTON
        
        let postButton = UIButton(type: .system)
        postButton.frame = CGRect(x: UIScreen.main.bounds.size.width - 50.0, y: 10, width: 40, height: 40)
        postButton.setTitle("Post", for: .normal)
        postButton.tintColor = UIColor.black
        postButton.backgroundColor = UIColor.white
        postButton.titleLabel?.font = .systemFont(ofSize: 18)
        postButton.titleLabel?.font =  UIFont(name: "ChalkboardSE-Regular", size: 18)
        postButton.addTarget(self, action: #selector(postAction), for: .touchUpInside)
        //self.view.addSubview(postButton)
    }
    
         
    // CHANNEL PICKER VIEW
    let channels1 = ["", "Travel", "Art", "Drama", "Gaming", "Meme", "Makeup", "Politics", "Music", "Sports", "Food", "Abroad", "Writing", "Development", "Financial", "Pets", "Job", "Astrology", "Horror", "Anime", "LGBTQ+", "Film", "Relationship", "Photography", "International"
    ]
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
      label1 = UILabel(frame: CGRect(x: 10, y: 55, width:UIScreen.main.bounds.size.width - 20.0, height: 40)) //was 155
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
    
    
    
    
    func textViewDidBeginEditing (_ textView: UITextView) {
        if myTxtview.text == "Enter your thoughts here..."  {
            myTxtview.text = ""
            myTxtview.textColor = .black
        }
        myTxtview.becomeFirstResponder()
    }
    
    func textViewDidEndEditing (_ textView: UITextView) {
        if myTxtview.text.isEmpty || myTxtview.text == "" {
            myTxtview.textColor = .black
            myTxtview.text = "Enter your thoughts here..."
        }
        myTxtview.resignFirstResponder()
    }
    
    
    // How to exit textfield, clicking away
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Function for setting return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    //for profile to anonymous change with switchbar
     @objc func switch2(_ sender: UISwitch) {
        if sender.isOn {
        button.setImage(UIImage(named: "sluglogoo.png"), for: .normal)
        
        }
        else {
         button.setImage(UIImage(named: "sluglogoo.png"), for: .normal)

        }
    }
    
    @objc func cancelingimage(_ sender: UIButton) {
        imagePreview.image = nil
        self.view.addSubview(myTxtview)
        imagePreview.removeFromSuperview()
        imageCancel.removeFromSuperview()
    }
 
    
    
   @objc func didShow(_ sender: NSNotification)
    {
        UITextView.animate(withDuration: 0.3) {
                   myTxtview.frame = CGRect(x: 10.0, y: 150.0, width:UIScreen.main.bounds.size.width - 20.0 , height: 150)
                   self.view.layoutIfNeeded()
               }
    }

   @objc func didHide(_ sender: NSNotification)
    {
        UITextView.animate(withDuration: 0.3) {
           myTxtview.frame = CGRect(x: 10.0, y: 150.0, width:UIScreen.main.bounds.size.width - 20.0 , height: 400.0)
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func doneButtonAction(_ sender: UIButton)
      {

        print("d")
    }
    
    
    // cancel button
    @objc func buttonAction(_ sender:UIButton!) {
        let ac = UIAlertController(title: "Are you sure you want to discard your post", message: nil, preferredStyle: .alert)
        
    
          
          ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
         ac.addAction(UIAlertAction(title: "Discard", style: .destructive, handler: discardaction))
         ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
          present(ac, animated: true)
    
    }
    func discardaction(action: UIAlertAction) {
        let storage = Storage.storage()
        let data = Data()
        let storageRef = storage.reference()
        let ref = storageRef.child("postImages/My garden")
        ref.delete { (error) in
            print(error)
        }
        imagePreview.image = nil
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    let notequal = [nil, "", "Title", "Enter your thoughts here..."]
    func title(title: String) -> String {
        if notequal.contains(title) {
            return "1"
        }
        return title
    }
    func body(body: String) -> String {
        if notequal.contains(body) {
            return "2"
        }
        return body
    }
    func channel(channel: String) -> String {
        if notequal.contains(channel) {
            return "3"
        }
        return channel
    }
    func assertions(title: String, body: String, channel: String){
       
        if (title == "1" && body == "2" && channel == "3") {
            let ac1 = UIAlertController(title: "Title, body, and channel are missing", message: "Please fill out these fields before posting", preferredStyle: .alert)
            ac1.addAction(UIAlertAction(title: "Ok", style: .default))
            return present(ac1, animated: true)
        }
        else if title == "1" && body == "2" {
            let ac1 = UIAlertController(title: "Title and body are missing", message: "Please fill out these fields before posting", preferredStyle: .alert)
            ac1.addAction(UIAlertAction(title: "Ok", style: .default))
            return present(ac1, animated: true)
        }
        else if body == "2" && channel == "3" {
            
            let ac1 = UIAlertController(title: "Body and channel are missing", message: "Please fill out these fields before posting", preferredStyle: .alert)
            ac1.addAction(UIAlertAction(title: "Ok", style: .default))
            return present(ac1, animated: true)
        }
        else if title == "1" && channel == "3" {
             let ac1 = UIAlertController(title: "Title and channel are missing", message: "Please fill out these fields before posting", preferredStyle: .alert)
             ac1.addAction(UIAlertAction(title: "Ok", style: .default))
             return present(ac1, animated: true)
        }
        else if title == "1"{
            let ac1 = UIAlertController(title: "Title is missing", message: "Please fill out this fields before posting", preferredStyle: .alert)
            ac1.addAction(UIAlertAction(title: "Ok", style: .default))
                           return present(ac1, animated: true)
            return present(ac1, animated: true)
        }
        else if body == "2"{
             let ac1 = UIAlertController(title: "Body is missing", message: "Please fill out this fields before posting", preferredStyle: .alert)
            ac1.addAction(UIAlertAction(title: "Ok", style: .default))
            return present(ac1, animated: true)
        }
        else if channel == "3"{
             let ac1 = UIAlertController(title: "Channel is missing", message: "Please fill out this fields before posting", preferredStyle: .alert)
             ac1.addAction(UIAlertAction(title: "Ok", style: .default))
             return present(ac1, animated: true)
        }
        else {
            if switchbar.isOn == false {
                Anonymity = true
            }
            else if switchbar.isOn == true {
                Anonymity = false
            }
            postData = [
                               "Author's Anonymity": Anonymity,
                               "title": titlepost.text!,
                               "body": myTxtview.text!,
                               "station": selectedchannel
            ]
            let db = Firestore.firestore()
            db.collection("newPost").document(selectedchannel).setData(postData) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                }
                              
            }
            return
        }
    }
    
    // post button
     @objc func postAction(sender: UIButton!) {
        let check1 = title(title: titlepost.text!)
        let check2 = body(body: myTxtview.text!)
        let check3 = channel(channel: selectedchannel)
        assertions(title: check1, body: check2, channel: check3)
    }
    
    var loadPhoto = UIButton()
    func displayUploadImageDialog(btnSelected: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true) {() -> Void in }
       
    
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imagePreview.image = image
        myTxtview.text = nil
        myTxtview.removeFromSuperview()
        self.view.addSubview(imagePreview)
        self.view.addSubview(imageCancel)
        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            uploadToStorage(fileURL: url)
        }
        self.dismiss(animated: true, completion: nil)
    }
    // : if request.auth != null;
    func uploadToStorage(fileURL: URL) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let localFile = fileURL
        let photoRef = storageRef.child("postImages/My garden")
        let uploadTask = photoRef.putFile(from: localFile, metadata: nil) { (metadata, err) in
            guard let metadata = metadata else {
                print(err?.localizedDescription)
                return
            }
            //imagePreview.sd_setImage(with: photoRef)
                    }
    }
    func showUpload() {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let ref = storageRef.child("postImages/My garden")
        imagePreview.sd_setImage(with: ref)
        
    }
    
    func checkPermission() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authStatus {
        case .authorized:
            print("ok man")
            self.displayUploadImageDialog(btnSelected: self.loadPhoto)
        case .denied:
            print("Error")
        default:
            break
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }

    func checkLibrary() {
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .authorized {
            switch photos {
            case .authorized:
                print("ok")
                self.displayUploadImageDialog(btnSelected: self.loadPhoto)
            case .denied:
                print("Error")
            default:
                break
            }
        }
    }
    
    @objc func loadPhotoTapped(_ sender: UIButton) {
        self.displayUploadImageDialog(btnSelected: self.loadPhoto)
        
            let photos = PHPhotoLibrary.authorizationStatus()
             if photos == .notDetermined {
                 PHPhotoLibrary.requestAuthorization({status in
                     if status == .authorized{
                         print("ok")
                     } else {
                         print("no")
                     }
                 })
             }
             checkLibrary()
             checkPermission()
        }
}
    
    
    












