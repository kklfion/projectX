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


let userIconButton = UIButton()
var postBodyText = UITextView()
var postTitle = UITextField()
var anonymousSwitch = UISwitch()
var pickerview = UIPickerView()
var Anonymity = false
var success = "No Errors"
var postImage = UIImage()
var label1 = UILabel()
var fullname = String()
var queryStations = QueryData()
var stations = [Station]()
var selectedStationIndex: Int?
//var stationNames = [String]()

class NewPostVC: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate,
                 UIImagePickerControllerDelegate, UINavigationControllerDelegate, UNUserNotificationCenterDelegate
{
    var textHeightConstraint: NSLayoutConstraint!
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if queryStations.loaded == false {
            queryStations.queryStations(completion: {result in
                switch result {
                case .success(let data):
                    stations.append(contentsOf: data)
                    
                    for station in stations{
                        //stationNames.append(station.stationName)
                    }
                case .failure(_):
                    break
                }
            })
        }
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // MARK: - X Button
        
        let Xbutton = UIButton(type: .system)
        Xbutton.frame = CGRect(x: 10, y: 15, width: 60, height: 60)
        Xbutton.setTitle("X", for: .normal)
        Xbutton.contentHorizontalAlignment = .left
        Xbutton.contentVerticalAlignment = .top
        Xbutton.tintColor = UIColor.black
        Xbutton.backgroundColor = UIColor.white
        Xbutton.titleLabel?.font = UIFont.systemFont(ofSize: 18,weight: .bold)
        //Xbutton.titleLabel?.font =  UIFont(name: "ChalkboardSE-Regular", size: 18)
        Xbutton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        self.view.addSubview(Xbutton)
        
        // MARK: - New Post Label
        
        let label = UILabel(frame: CGRect(x: 10, y: 10, width:UIScreen.main.bounds.size.width - 20.0, height: 35))
        //label.center = CGPoint(x: 50, y: 50)
        label.textAlignment = .center
        label.text = "New Post"
        label.textColor = Constants.Colors.darkBrown
        label.font = UIFont.systemFont(ofSize: 25,weight: .heavy)
        //label.font = UIFont (name: "ChalkboardSE-Regular" , size: 30)
        self.view.addSubview(label)
        
        // MARK: - Choose Station
        
        let chooseStation = UIButton(type: .system)
        chooseStation.frame = CGRect(x: 0.0, y: 75.0, width: UIScreen.main.bounds.size.width, height: 40) //was 155
        chooseStation.setTitle("  Choose a station >", for: .normal)
        chooseStation.contentHorizontalAlignment = .left
        chooseStation.tintColor = UIColor.black
        chooseStation.backgroundColor = UIColor.white
        chooseStation.layer.borderWidth = 0.3
        chooseStation.layer.borderColor = (UIColor( red: 0, green: 0, blue:0, alpha: 0.5)).cgColor
        chooseStation.titleLabel?.font = UIFont.systemFont(ofSize: 15,weight: .regular)
        //chooseChannel.titleLabel?.font =  UIFont(name: "ChalkboardSE-Regular", size: 15) // Delete if custom font
        chooseStation.addTarget(self, action: #selector(stationAction), for: .touchUpInside)
        self.view.addSubview(chooseStation)
        
        // MARK: - TextField & TextView
        
        // MARK: Post Title
        postTitle = UITextField(frame: CGRect(x: 10.0, y: 120.0, width:UIScreen.main.bounds.size.width - 20.0 , height: 40.0))//was 200
        //postTitle.backgroundColor = .white
        postTitle.attributedPlaceholder = NSAttributedString(string: Constants.NewPost.placeholderTitleText, attributes: [NSAttributedString.Key.foregroundColor: Constants.Colors.darkBrown])
        postTitle.font = UIFont.systemFont(ofSize: 19,weight: .bold)
        //postTitle.font = UIFont (name: "ChalkboardSE-Regular" , size: 20.0)
        postTitle.tintColor = UIColor.black
        postTitle.delegate = self
        self.view.addSubview(postTitle)
        
        // MARK: Post Body
        //postBodyText.frame = CGRect(x: 10.0, y: 170.0, width:UIScreen.main.bounds.size.width - 20.0 , height: 400.0)
        
        postBodyText.isScrollEnabled = true
        //postBodyText.backgroundColor = .white
        postBodyText.delegate = self
        postBodyText.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        //postBodyText.font = UIFont (name: "ChalkboardSE-Regular" , size: 15)
        postBodyText.textAlignment = .left
        postBodyText.text = Constants.NewPost.placeholderBodyText
        postBodyText.textColor = Constants.Colors.placeholderTextColor
        postBodyText.tintColor = Constants.Colors.textColor
        
        self.view.addSubview(postBodyText)
        
        postBodyText.addAnchors(top: postTitle.bottomAnchor, leading: postTitle.leadingAnchor, bottom: nil, trailing: postTitle.trailingAnchor, padding: .init(top: 0, left: -4, bottom: 0, right: 0))
        self.textHeightConstraint = postBodyText.heightAnchor.constraint(equalToConstant: 40)
        self.textHeightConstraint.isActive = true
        self.adjustTextViewHeight(postBodyText)
                
        // MARK: - Toolbar
        let tool = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        tool.backgroundColor = .white
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let fixSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixSpace.width = 8
        let fixSpace1 = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixSpace1.width = 12
        
        
        
        // MARK: User Icon
        userIconButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        let userIconContainer = UIView(frame: userIconButton.frame)
        //button.sizeToFit()
        userIconButton.setImage(UIImage(named: "sluglogoo"), for: .normal)
        userIconContainer.sizeToFit()
        userIconContainer.addSubview(userIconButton)
        
        // MARK: Anon Switch
        anonymousSwitch.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        anonymousSwitch.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        let ButtonView = UIView(frame: anonymousSwitch.frame)
        anonymousSwitch.sizeToFit()
        anonymousSwitch.isOn = true
        anonymousSwitch.onTintColor = Constants.Colors.darkBrown
        anonymousSwitch.setOn(true, animated: false)
        anonymousSwitch.addTarget(self, action: #selector(switch2(_:)), for: .valueChanged)
        ButtonView.sizeToFit()
        ButtonView.addSubview(anonymousSwitch)
        
        // MARK: attach Button
        let attachButton = UIButton()
        attachButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let attachButtonContainer = UIView(frame: attachButton.frame)
        let sfConfiguration = UIImage.SymbolConfiguration(pointSize: 25)
        attachButton.setImage(UIImage(systemName: "paperclip", withConfiguration: sfConfiguration), for: .normal)
        attachButton.tintColor = Constants.Colors.darkBrown
        attachButton.addTarget(self, action: #selector(loadPhotoTapped), for: .touchUpInside)
        attachButtonContainer.sizeToFit()
        attachButtonContainer.addSubview(attachButton)
        
        // MARK: photo Button
        let photoButton = UIButton()
        photoButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let photoButtonContainer = UIView(frame: photoButton.frame)
        photoButton.setImage(UIImage(systemName: "photo.fill", withConfiguration: sfConfiguration), for: .normal)
        photoButton.tintColor = Constants.Colors.darkBrown
        photoButton.addTarget(self, action: #selector(loadPhotoTapped), for: .touchUpInside)
        photoButtonContainer.sizeToFit()
        photoButtonContainer.addSubview(photoButton)
        
        // MARK: Send Button
        let sendButton = UIButton()
        sendButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let sendButtonContainer = UIView(frame: sendButton.frame)
        sendButton.setImage(UIImage(systemName: "paperplane.circle.fill", withConfiguration: sfConfiguration), for: .normal)
        sendButton.tintColor = Constants.Colors.darkBrown
        sendButton.addTarget(self, action: #selector(postAction), for: .touchUpInside)
        sendButtonContainer.sizeToFit()
        sendButtonContainer.addSubview(sendButton)
        
        
        let toolUserIcon = UIBarButtonItem()
        toolUserIcon.customView = userIconContainer
        
        let toolAttachButton = UIBarButtonItem()
        toolAttachButton.customView = attachButtonContainer
        
        let toolPhotoButton = UIBarButtonItem()
        toolPhotoButton.customView = photoButtonContainer
        
        let toolSendButton = UIBarButtonItem()
        toolSendButton.customView = sendButtonContainer
        
        let barSwitch = UIBarButtonItem()
        barSwitch.customView = ButtonView
        
        
        tool.barTintColor = .white
        tool.isTranslucent = false
        tool.clipsToBounds = true
        tool.setItems([fixSpace1, toolUserIcon, fixSpace, barSwitch, flexSpace,toolAttachButton,fixSpace,toolPhotoButton,fixSpace, toolSendButton, fixSpace1] , animated: true)
        tool.sizeToFit()
        postTitle.inputAccessoryView = tool
        postBodyText.inputAccessoryView = tool
    }
    
    
    
    
    // MARK: - Station Picker View
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stations[row].stationName
        //return stationNames[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stations.count
        //return stationNames.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedStationIndex = row
        //selectedchannel = stationNames[row]
        doneButton()
    }
    
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    var label1 = UILabel()
    var counter = 1
    @IBAction func stationAction(sender: UIButton!) {
        self.view.endEditing(true)
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
        toolBar.tintColor = Constants.Colors.darkBrown
        // hide toolbar
        //self.view.addSubview(toolBar)
    }
    @objc func doneButton() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        if let stationIndex = selectedStationIndex
        {
            if counter == 1{
                label1 = UILabel(frame: CGRect(x: 10, y: 75, width:UIScreen.main.bounds.size.width - 20.0, height: 40)) //was 155
                
                label1.textAlignment = .center
                label1.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
                //label1.font = UIFont (name: "ChalkboardSE-Regular" , size: 15) // Delete if custom font
                label1.text = stations[stationIndex].stationName
                self.view.addSubview(label1)
                counter += 1
            }
            else {
                label1.text = stations[stationIndex].stationName
            }
        }
        
    }
    // END OF CHANNEL PICKER VIEW
    
    
    func adjustTextViewHeight(_ textView: UITextView) {
        let fixedWidth = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        if newSize.height < 80
        {
            self.textHeightConstraint.constant = 80
        }
        else
        {
            self.textHeightConstraint.constant = newSize.height
        }
        //self.textHeightConstraint.constant = newSize.height
        self.view.layoutIfNeeded()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.adjustTextViewHeight(textView)
    }
    func textViewDidBeginEditing (_ textView: UITextView) {
        picker.removeFromSuperview()
        if postBodyText.text == Constants.NewPost.placeholderBodyText  {
            postBodyText.text = ""
            postBodyText.textColor = Constants.Colors.textColor
        }
        postBodyText.becomeFirstResponder()
    }
    
    func textViewDidEndEditing (_ textView: UITextView) {
        if postBodyText.text.isEmpty || postBodyText.text == "" {
            postBodyText.textColor = Constants.Colors.placeholderTextColor
            postBodyText.text = Constants.NewPost.placeholderBodyText
        }
        postBodyText.resignFirstResponder()
    }
    
    
    // How to exit textfield, clicking away
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        picker.removeFromSuperview()
    }
    
    // Function for setting return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    //for profile to anonymous change with switchbar
    @objc func switch2(_ sender: UISwitch) {
        if sender.isOn {
            userIconButton.alpha = 1.0
            
        }
        else {
            userIconButton.alpha = 0.3
            
        }
    }
    
    // cancel button
    @objc func dismissAction(_ sender:UIButton!) {
        let ac = UIAlertController(title: "Are you sure you want to discard your post?", message: nil, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Keep Editing", style: .cancel))
        ac.addAction(UIAlertAction(title: "Discard", style: .destructive, handler: discardaction))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
        
    }
    func discardaction(action: UIAlertAction) {
        //when discared, clear out channel and deload station options
        //stationNames.removeAll()
        queryStations.loaded = false
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    let notequal = [nil, "", "Title", "Enter your thoughts here..."]
    /*func title(title: String) -> String {
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
    }*/
    /*
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
            if anonymousSwitch.isOn == false {
                Anonymity = true
            }
            else if anonymousSwitch.isOn == true {
                Anonymity = false
            }
            postData = [
                "Author's Anonymity": Anonymity,
                "title": postTitle.text!,
                "body": postBodyText.text!,
                "station": selectedchannel
            ]
            let db = Firestore.firestore()
            guard let userID = Auth.auth().currentUser?.uid else{return}
            //Recalling users data for post
            let docRef = db.collection("users").document(userID)
            
            docRef.getDocument{ (document, error) in
                let result = Result {
                    try document?.data(as: User.self)
                }
                switch result {
                case .success(let user):
                    if let user = user{
                        //A 'user' value was successfully initalized from the documentSnapshot
                        fullname = user.name
                        
                        //FIXED - when post is made it assigns correct station ID
                        var stationIden = String()
                        for station in stations{
                            if station.stationName == self.selectedchannel{
                                stationIden = station.id!
                            }
                        }
                        
                        let newPost = Post(stationID: stationIden, stationName: self.selectedchannel, likes: 0, userInfo: user, title: postTitle.text!, text: postBodyText.text!, date: Date(), imageURL: nil, commentCount: 0)
                        
                        do{
                            try db.collection("posts").document().setData(from: newPost)
                        }catch let error{
                            print("Error writing to Firestore: \(error)")
                        }
                        
                        
                    } else{
                        //A stupid nil value was given, either from successful initlization or the snapShot was nil
                        //print("Document not exsist")
                    }
                case .failure(let error):
                    // A user value could not be initialized from DocumnetSnapshot
                    print("Error decoding city: \(error)")
                }
            }
            //print("Success")
            //Removing all
            return
        }
    }*/
    // post button
    @objc func postAction(sender: UIButton!) {
        
        //let check1 = title(title: postTitle.text!)
        //let check2 = body(body: postBodyText.text!)
        //let check3 = channel(channel: selectedchannel)
       // assertions(title: check1, body: check2, channel: check3)
        
        // MARK: Check Post requirements
        guard let user = UserManager.shared().getCurrentUserData().0, let _ = Auth.auth().currentUser
        else
        {
            let errorPopup = UIAlertController(title: "User isn't signed in", message: "Please sign in before posting", preferredStyle: .alert)
            errorPopup.addAction(UIAlertAction(title: "Ok", style: .default))
            return present(errorPopup, animated: true)
        }
        guard postTitle.text != nil, postTitle.text != "", selectedStationIndex != nil, let selectedStationIndex = selectedStationIndex, let title = postTitle.text, var bodyText = postBodyText.text
        else {
            let errorPopup = UIAlertController(title: "Station and Title can not be Empty!", message: "Please fill out these fields before posting", preferredStyle: .alert)
            errorPopup.addAction(UIAlertAction(title: "Ok", style: .default))
            return present(errorPopup, animated: true)
        }
        if bodyText == Constants.NewPost.placeholderBodyText
        {
            bodyText = ""
        }

        let stationID = stations[selectedStationIndex].id!
        let postData = Post(stationID: stationID, stationName: stations[selectedStationIndex].stationName, likes: 0, commentCount: 0, userInfo: user, title: title, text: bodyText, date: Date(), isAnonymous: !anonymousSwitch.isOn)
        let db = Firestore.firestore()
        do{
            try db.collection("posts").document().setData(from: postData)
        }
        catch let error{
            print("Error writing to Firestore: \(error)")
        }
    }
    
    
    
    
    
    var loadPhoto = UIButton()
    func displayUploadImageDialog(btnSelected: UIButton) {
        //        let picker = UIImagePickerController()
        //        picker.delegate = self
        //        picker.allowsEditing = true
        //        if UI_USER_INTERFACE_IDIOM() == .pad {
        //            OperationQueue.main.addOperation({() -> Void in
        //                picker.sourceType = .photoLibrary
        //                self.present(picker, animated: true) {() -> Void in }
        //            })
        //        }
        //        else {
        //            picker.sourceType = .photoLibrary
        //            self.present(picker, animated: true) {() -> Void in }
        //        }
    }
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as! UIImage
        let postImage = image
        _ = image.jpegData(compressionQuality: 0.05)
        _ = UIImageView(image: postImage)
        self.dismiss(animated: true, completion: nil)
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
                    //print("ok")
                } else {
                    // print("no")
                }
            })
        }
        checkLibrary()
        checkPermission()
    }
}















