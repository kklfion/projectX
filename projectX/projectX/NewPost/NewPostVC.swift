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
import ProgressHUD



class NewPostVC: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate,
                 UIImagePickerControllerDelegate, UINavigationControllerDelegate, UNUserNotificationCenterDelegate
{
    // UI Element Declarations
    let userIconButton = UIButton()
    var postBodyText = UITextView()
    var postImageView = UIImageView()
    let postImageXButton = UIButton()
    var postImageData: UIImage?
    var postTitle = UITextField()
    var anonymousSwitch = UISwitch()
    var pickerview = UIPickerView()
    var selectedStationLabel = UILabel()
    let chooseStation = UIButton(type: .system)

    // Data
    var queryStations = QueryData()
    var stations = [Station]()
    var selectedStationIndex: Int?
    
    // Other
    let sfConfiguration = UIImage.SymbolConfiguration(pointSize: 25)
    var textHeightConstraint: NSLayoutConstraint!
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if queryStations.loaded == false {
            queryStations.queryStations(completion: {result in
                switch result {
                case .success(let data):
                    self.stations.append(contentsOf: data)
                case .failure(_):
                    break
                }
            })
        }
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        isModalInPresentation = true
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
        Xbutton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        self.view.addSubview(Xbutton)
        
        // MARK: - New Post Label
        let newPostLabel = UILabel(frame: CGRect(x: 10, y: 10, width:UIScreen.main.bounds.size.width - 20.0, height: 35))
        newPostLabel.textAlignment = .center
        newPostLabel.text = "New Post"
        newPostLabel.textColor = Constants.Colors.darkBrown
        newPostLabel.font = UIFont.systemFont(ofSize: 25,weight: .heavy)
        self.view.addSubview(newPostLabel)
        
        // MARK: - Choose Station
        chooseStation.frame = CGRect(x: 0.0, y: 75.0, width: UIScreen.main.bounds.size.width, height: 40) //was 155
        chooseStation.setTitle("  Choose a station >", for: .normal)
        chooseStation.contentHorizontalAlignment = .left
        chooseStation.tintColor = UIColor.black
        chooseStation.backgroundColor = UIColor.white
        chooseStation.layer.borderWidth = 0.3
        chooseStation.layer.borderColor = (UIColor( red: 0, green: 0, blue:0, alpha: 0.5)).cgColor
        chooseStation.titleLabel?.font = UIFont.systemFont(ofSize: 15,weight: .regular)
        chooseStation.addTarget(self, action: #selector(stationAction), for: .touchUpInside)
        self.view.addSubview(chooseStation)
        
        // MARK: - TextField & TextView
        
        // MARK: Post Image
        postImageView.layer.cornerRadius = 8.0
        postImageView.clipsToBounds = true
        self.view.addSubview(postImageView)
        
        // MARK: post image X button
        postImageXButton.setImage( UIImage(systemName: "xmark.circle.fill"), for: .normal)
        postImageXButton.tintColor = Constants.Colors.darkBrown //.lightGray
        postImageXButton.addTarget(self, action: #selector(postImageXPressed), for: .touchUpInside)
        self.view.addSubview(postImageXButton)
        
        
        // MARK: Post Title
        postTitle.attributedPlaceholder = NSAttributedString(string: Constants.NewPost.placeholderTitleText, attributes: [NSAttributedString.Key.foregroundColor: Constants.Colors.darkBrown])
        postTitle.font = UIFont.systemFont(ofSize: 19,weight: .bold)
        //postTitle.font = UIFont (name: "ChalkboardSE-Regular" , size: 20.0)
        postTitle.tintColor = UIColor.black
        postTitle.delegate = self
        self.view.addSubview(postTitle)
        
        // MARK: Post Body
        postBodyText.isScrollEnabled = true
        postBodyText.delegate = self
        postBodyText.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        postBodyText.textAlignment = .left
        postBodyText.text = Constants.NewPost.placeholderBodyText
        postBodyText.textColor = Constants.Colors.placeholderTextColor
        postBodyText.tintColor = Constants.Colors.textColor
        self.view.addSubview(postBodyText)
        
        // MARK: - ADD Constraints
        postImageView.addAnchors(top: chooseStation.bottomAnchor, leading: chooseStation.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 15, left: 15, bottom: 0, right: 10))
        postTitle.addAnchors(top: postImageView.bottomAnchor, leading: chooseStation.leadingAnchor, bottom: nil, trailing: chooseStation.trailingAnchor, padding: .init(top: 5, left: 15, bottom: 0, right: 10))
        
        postBodyText.addAnchors(top: postTitle.bottomAnchor, leading: postTitle.leadingAnchor, bottom: nil, trailing: postTitle.trailingAnchor, padding: .init(top: 5, left: -4, bottom: 0, right: 0))
        self.textHeightConstraint = postBodyText.heightAnchor.constraint(equalToConstant: 40)
        self.textHeightConstraint.isActive = true
        self.adjustTextViewHeight(postBodyText)
        
        // MARK: - Toolbar
        let toolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolbar.backgroundColor = .white
        let toolbarFlexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbarFixSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        toolbarFixSpace.width = 8
        let toolbarFixSpace2 = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        toolbarFixSpace2.width = 12
        
        
        
        // MARK: User Icon
        userIconButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        let userIconContainer = UIView(frame: userIconButton.frame)
        userIconButton.setImage(UIImage(named: "sluglogoo"), for: .normal)
        userIconContainer.sizeToFit()
        userIconContainer.addSubview(userIconButton)
        
        // MARK: Anon Switch
        anonymousSwitch.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        anonymousSwitch.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        let anonymousSwitchView = UIView(frame: anonymousSwitch.frame)
        anonymousSwitch.sizeToFit()
        anonymousSwitch.isOn = true
        anonymousSwitch.onTintColor = Constants.Colors.darkBrown
        anonymousSwitch.setOn(true, animated: false)
        anonymousSwitch.addTarget(self, action: #selector(switch2(_:)), for: .valueChanged)
        anonymousSwitchView.sizeToFit()
        anonymousSwitchView.addSubview(anonymousSwitch)
        
        // MARK: attach Button
        let attachButton = UIButton()
        attachButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        attachButton.isHidden = true
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
        barSwitch.customView = anonymousSwitchView
        
        toolbar.barTintColor = .white
        toolbar.isTranslucent = false
        toolbar.clipsToBounds = true
        toolbar.setItems([toolbarFixSpace2, toolUserIcon, toolbarFixSpace, barSwitch, toolbarFlexSpace,toolAttachButton,toolbarFixSpace,toolPhotoButton,toolbarFixSpace, toolSendButton, toolbarFixSpace2] , animated: true)
        toolbar.sizeToFit()
        postTitle.inputAccessoryView = toolbar
        postBodyText.inputAccessoryView = toolbar
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
    }
    @objc func postImageXPressed()
    {
        postImageView.image = nil
        postImageData = nil
        for const in postImageView.constraints
        {
            postImageView.removeConstraint(const)
        }
        for const in postImageXButton.constraints
        {
            postImageXButton.removeConstraint(const)
        }
        
    }
    @objc func doneButton() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        if let stationIndex = selectedStationIndex
        {
            if counter == 1{
                selectedStationLabel = UILabel(frame: CGRect(x: 10, y: 75, width:UIScreen.main.bounds.size.width - 20.0, height: 40)) //was 155
                selectedStationLabel.textAlignment = .center
                selectedStationLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
                selectedStationLabel.text = stations[stationIndex].stationName
                self.view.addSubview(selectedStationLabel)
                counter += 1
            }
            else {
                selectedStationLabel.text = stations[stationIndex].stationName
            }
        }
        
    }
    
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
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        picker.removeFromSuperview()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func switch2(_ sender: UISwitch) {
        if sender.isOn {
            userIconButton.alpha = 1.0
            
        }
        else {
            userIconButton.alpha = 0.3
            
        }
    }
    
    @objc func dismissAction(_ sender:UIButton!) {
        dismissAlert()
    }
    func dismissAlert()
    {
        let ac = UIAlertController(title: "Are you sure you want to discard your post?", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Keep Editing", style: .cancel))
        ac.addAction(UIAlertAction(title: "Discard", style: .destructive, handler: discardaction))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    func discardaction(action: UIAlertAction) {
        queryStations.loaded = false
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Post Action
    @objc func postAction(sender: UIButton!) {
        
        // Check Post requirements
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
        
        // upload image if there is
        if postImageData != nil
        {
            uploadImage(imageData: postImageData) { (downloadURL) in
                let stationID = self.stations[selectedStationIndex].id!
                let postData = Post(stationID: stationID, stationName: self.stations[selectedStationIndex].stationName, likes: 0, commentCount: 0, userInfo: user, title: title, text: bodyText, date: Date(), imageURL: downloadURL, isAnonymous: !self.anonymousSwitch.isOn)
                let db = Firestore.firestore()
                do{
                    try db.collection("posts").document().setData(from: postData)
                }
                catch let error{
                    print("Error writing to Firestore: \(error)")
                }
                ProgressHUD.showSuccess()
                self.dismiss(animated: true, completion: nil)
            }
        }
        else
        {
            let stationID = stations[selectedStationIndex].id!
            let postData = Post(stationID: stationID, stationName: stations[selectedStationIndex].stationName, likes: 0, commentCount: 0, userInfo: user, title: title, text: bodyText, date: Date(), isAnonymous: !anonymousSwitch.isOn)
            let db = Firestore.firestore()
            do{
                try db.collection("posts").document().setData(from: postData)
            }
            catch let error{
                print("Error writing to Firestore: \(error)")
            }
            ProgressHUD.showSuccess()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    var loadPhoto = UIButton()
    func displayUploadImageDialog(btnSelected: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        if UIScreen.main.traitCollection.userInterfaceIdiom == .pad {
            OperationQueue.main.addOperation({() -> Void in
                picker.sourceType = .photoLibrary
                self.present(picker, animated: true) {() -> Void in }
            })
        }
        else {
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true) {() -> Void in }
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        postImageData = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        postImageView.addAnchors(top: chooseStation.bottomAnchor, leading: chooseStation.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 15, left: 15, bottom: 0, right: 10), size: .init(width: 100, height: 100))
        postImageXButton.addAnchors(top: postImageView.topAnchor, leading: postImageView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: -15, left: -15, bottom: 0, right: 0), size: .init(width: 30, height: 30))
        postImageView.image = postImageData
        
        self.dismiss(animated: true, completion: nil)
    }
    func uploadImage(imageData: UIImage?, completionHandler: @escaping (_ downloadURL:URL) -> Void)
    {
        guard let postImageCompressed = imageData?.jpegData(compressionQuality: 0.05)
        else
        {
            return
        }
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let imageRef = storageRef.child("postImages/\(UUID()).jpg")
        let uploadTask = imageRef.putData(postImageCompressed, metadata: nil) { (metadata, error) in
            if error != nil
            {
                ProgressHUD.showFailed()
            }
            else
            {
                ProgressHUD.showSuccess()
            }
            
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    return
                }
                print(downloadURL)
                completionHandler(downloadURL)
            }
        }
        
        let _ = uploadTask.observe(.progress) { snapshot in
            guard let progress = snapshot.progress
            else {return}
            ProgressHUD.animationType = .horizontalCirclesPulse
            ProgressHUD.colorHUD = .systemGray
            ProgressHUD.colorBackground = .clear
            ProgressHUD.colorProgress = Constants.Colors.darkBrown
            ProgressHUD.showProgress(CGFloat(progress.fractionCompleted))
        }
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

extension NewPostVC: UIAdaptivePresentationControllerDelegate
{
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        dismissAlert()
    }
}
