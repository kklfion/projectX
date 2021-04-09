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
import YPImagePicker


class NewPostVC: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate,
                 UIImagePickerControllerDelegate, UINavigationControllerDelegate, UNUserNotificationCenterDelegate
{
    // Init
    var isMission = false
    // UI Element Declarations
    let userIconButton = UIButton()
    var postBodyText = UITextView()
    var postImageData = [UIImage]()
    var postTitle = UITextField()
    var anonymousSwitch = UISwitch()
    var pickerview = UIPickerView()
    var selectedStationLabel = UILabel()
    let chooseStation = UIButton(type: .system)
    var loadPhoto = UIButton()
    var toolBar = UIToolbar()
    var stationToolBar = UIToolbar()
    var picker  = UIPickerView()
    var counter = 1
    
    // Data
    var queryStations = QueryData()
    var stations = [Station]()
    var downloadURLs = [URL]()
    var selectedStationIndex: Int?
    let postsCollection = "posts"
    let missionsCollection = "missions"
    var destinationCollection = "posts"
    
    // Other
    let sfConfiguration = UIImage.SymbolConfiguration(pointSize: 25)
    var textHeightConstraint: NSLayoutConstraint!
    
    let cellId = "cellId"
    //var imagePreviewCollection: UICollectionView?
    let imagePreviewCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 10)
        
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.isScrollEnabled = true
        return collection
    }()
    
    
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
        view.backgroundColor = Constants.Colors.mainBackground
        
        self.view.addSubview(imagePreviewCollection)
        imagePreviewCollection.delegate = self
        imagePreviewCollection.dataSource = self
        imagePreviewCollection.register(CustomCell.self, forCellWithReuseIdentifier: cellId)
        
        if isMission
        {
            destinationCollection = missionsCollection
        }
        else
        {
            destinationCollection = postsCollection
        }
        
        // MARK: - X Button
        let Xbutton = UIButton(type: .system)
        Xbutton.frame = CGRect(x: 10, y: 15, width: 60, height: 60)
        Xbutton.setTitle("X", for: .normal)
        Xbutton.contentHorizontalAlignment = .left
        Xbutton.contentVerticalAlignment = .top
        Xbutton.tintColor = Constants.Colors.darkBrown
        Xbutton.backgroundColor = Constants.Colors.mainBackground
        Xbutton.titleLabel?.font = UIFont.systemFont(ofSize: 18,weight: .bold)
        Xbutton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        self.view.addSubview(Xbutton)
        
        // MARK: - New Post Label
        let newPostLabel = UILabel(frame: CGRect(x: 10, y: 10, width:UIScreen.main.bounds.size.width - 20.0, height: 35))
        newPostLabel.textAlignment = .center
        newPostLabel.text = "New Post"
        if isMission
        {
            newPostLabel.text = "New Mission"
        }
        newPostLabel.textColor = Constants.Colors.mainText
        newPostLabel.font = UIFont.systemFont(ofSize: 25,weight: .heavy)
        self.view.addSubview(newPostLabel)
        
        // MARK: - Choose Station
        chooseStation.frame = CGRect(x: -1.0, y: 75.0, width: UIScreen.main.bounds.size.width + 2, height: 40) //was 155
        chooseStation.setTitle("  Choose a station >", for: .normal)
        chooseStation.contentHorizontalAlignment = .left
        chooseStation.tintColor = Constants.Colors.mainText
        chooseStation.backgroundColor = Constants.Colors.mainBackground
        chooseStation.layer.borderWidth = 0.3
        chooseStation.layer.borderColor = UIColor.systemGray.cgColor//(UIColor( red: 0, green: 0, blue:0, alpha: 0.5)).cgColor
        chooseStation.titleLabel?.font = UIFont.systemFont(ofSize: 15,weight: .regular)
        chooseStation.addTarget(self, action: #selector(stationAction), for: .touchUpInside)
        self.view.addSubview(chooseStation)
        
        // MARK: - TextField & TextView
        
        
        // MARK: Post Title
        postTitle.attributedPlaceholder = NSAttributedString(string: Constants.NewPost.placeholderTitleText, attributes: [NSAttributedString.Key.foregroundColor: Constants.Colors.mainText])
        postTitle.font = UIFont.systemFont(ofSize: 19,weight: .bold)
        //postTitle.font = UIFont (name: "ChalkboardSE-Regular" , size: 20.0)
        postTitle.tintColor = Constants.Colors.mainText
        postTitle.delegate = self
        self.view.addSubview(postTitle)
        
        // MARK: Post Body
        postBodyText.isScrollEnabled = true
        postBodyText.delegate = self
        postBodyText.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        postBodyText.textAlignment = .left
        postBodyText.text = Constants.NewPost.placeholderBodyText
        postBodyText.textColor = Constants.Colors.subText
        postBodyText.tintColor = Constants.Colors.mainText
        postBodyText.backgroundColor = Constants.Colors.mainBackground
        self.view.addSubview(postBodyText)
        
        // MARK: - ADD Constraints
        imagePreviewCollection.addAnchors(top: chooseStation.bottomAnchor, leading: chooseStation.leadingAnchor, bottom: nil, trailing: chooseStation.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        imagePreviewCollection.heightAnchor.constraint(equalToConstant: 0).isActive = true
        
        postTitle.addAnchors(top: imagePreviewCollection.bottomAnchor, leading: chooseStation.leadingAnchor, bottom: nil, trailing: chooseStation.trailingAnchor, padding: .init(top: 0, left: 15, bottom: 0, right: 10))
        
        postBodyText.addAnchors(top: postTitle.bottomAnchor, leading: postTitle.leadingAnchor, bottom: nil, trailing: postTitle.trailingAnchor, padding: .init(top: 0, left: -4, bottom: 0, right: 0))
        self.textHeightConstraint = postBodyText.heightAnchor.constraint(equalToConstant: 40)
        self.textHeightConstraint.isActive = true
        self.adjustTextViewHeight(postBodyText)
        
        
        
        
        
        // MARK: User Icon
        userIconButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        let userIconContainer = UIView(frame: userIconButton.frame)
        userIconButton.setImage(UIImage(named: "sluglogoo"), for: .normal)
        userIconContainer.sizeToFit()
        userIconContainer.addSubview(userIconButton)
        
        // MARK: Anon Switch
        anonymousSwitch.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        anonymousSwitch.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        let anonymousSwitchContainer = UIView(frame: anonymousSwitch.frame)
        anonymousSwitch.sizeToFit()
        anonymousSwitch.isOn = true
        anonymousSwitch.onTintColor = Constants.Colors.darkBrown
        anonymousSwitch.thumbTintColor = Constants.Colors.secondaryBackground
        anonymousSwitch.setOn(true, animated: false)
        anonymousSwitch.addTarget(self, action: #selector(switch2(_:)), for: .valueChanged)
        anonymousSwitchContainer.sizeToFit()
        anonymousSwitchContainer.addSubview(anonymousSwitch)
        
        // MARK: Hide User Icon and Anonymous switch for mission posts
        if isMission
        {
            userIconContainer.isHidden = true
            anonymousSwitchContainer.isHidden = true
        }
        
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
        barSwitch.customView = anonymousSwitchContainer
        
        // MARK: - Toolbar
        let toolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolbar.backgroundColor = Constants.Colors.mainBackground
        let toolbarFlexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbarFixSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        toolbarFixSpace.width = 8
        let toolbarFixSpace2 = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        toolbarFixSpace2.width = 12
        toolbar.barTintColor = Constants.Colors.mainBackground
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
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stations.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedStationIndex = row
        doneButton()
    }
    
    
    
    @IBAction func stationAction(sender: UIButton!) {
        self.view.endEditing(true)
        picker = UIPickerView.init()
        picker.delegate = self
        picker.backgroundColor = Constants.Colors.mainBackground
        picker.setValue(Constants.Colors.mainText, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
        stationToolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 35))
        stationToolBar.items = [UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil),UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(doneButton))]
        stationToolBar.tintColor = Constants.Colors.secondaryBackground

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
            postBodyText.textColor = Constants.Colors.mainText
        }
        postBodyText.becomeFirstResponder()
    }
    
    func textViewDidEndEditing (_ textView: UITextView) {
        if postBodyText.text.isEmpty || postBodyText.text == "" {
            postBodyText.textColor = .systemGray
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
        if postImageData.count > 0
        {
            uploadImages(imageDataArray: postImageData) { (downloadURLs) in
                let stationID = self.stations[selectedStationIndex].id!
                self.uploadData(ID: stationID, stationName: self.stations[selectedStationIndex].stationName, userInfo: user, title: title, bodyText: bodyText, imageURLArray: downloadURLs)
            }
        }
        else
        {
            let stationID = stations[selectedStationIndex].id!
            uploadData(ID: stationID, stationName: stations[selectedStationIndex].stationName, userInfo: user, title: title, bodyText: bodyText, imageURLArray: nil)
        }
    }
    func uploadData(ID: String, stationName: String, userInfo: User, title: String, bodyText: String, imageURLArray: [URL]?)
    {
        print("Uploading post")
        let db = Firestore.firestore()
        if isMission
        {
            let data = Mission(stationID: ID, stationName: stationName, likes: 0, userInfo: userInfo, title: title, text: bodyText, date: Date(), imageURLArray: imageURLArray)
            do{
                try db.collection(self.destinationCollection).document().setData(from: data)
            }
            catch let error{
                print("Error writing to Firestore: \(error)")
                showUploadError()
                return
            }
            ProgressHUD.showSuccess()
            self.dismiss(animated: true, completion: nil)
        }
        else
        {

            let data = Post(stationID: ID, stationName: stationName, likes: 0, commentCount: 0, authorID: userInfo.userID, title: title, text: bodyText, date: Date(),imageURL: imageURL, isAnonymous: !anonymousSwitch.isOn)

            do{
                try db.collection(self.destinationCollection).document().setData(from: data)
            }
            catch let error{
                print("Error writing to Firestore: \(error)")
                showUploadError()
                return
            }
            ProgressHUD.showSuccess()
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    func showUploadError()
    {
        let ac = UIAlertController(title: "Post Error", message: "There was an error submitting your post. Please try again", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    func displayUploadImageDialog(btnSelected: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        
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
    func uploadImages(imageDataArray: [UIImage]?, completionHandler: @escaping (_ downloadURLs:[URL]) -> Void)
    {
        
        guard let ImageArray = imageDataArray
        else
        {
            return
        }
        upload(index: 0, imageArray: ImageArray) {
            let URLs = self.downloadURLs
            completionHandler(URLs)
        }
    }
    func upload(index: Int, imageArray: [UIImage], completionHandler: (() -> Void)?)
    {
        if index < imageArray.count
        {
            let imageData = imageArray[index]
            guard let postImageCompressed = imageData.jpegData(compressionQuality: 0.05)
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
                        self.showUploadError()
                        return
                    }
                    self.downloadURLs.append(downloadURL)
                    self.upload(index: index + 1, imageArray: imageArray, completionHandler: completionHandler)
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
        else
        {
            completionHandler?()
        }
    }
    func checkPermission() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authStatus {
        case .authorized:
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
                self.displayUploadImageDialog(btnSelected: self.loadPhoto)
            case .denied:
                print("Error")
            default:
                break
            }
        }
    }
    func attachLimitReached()
    {
        let ac = UIAlertController(title: "Sorry, the maximum number of images is 5", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    @objc func loadPhotoTapped(_ sender: UIButton) {
        if postImageData.count < 5 {}
        else
        {
            attachLimitReached()
            return
        }
        
        var config = YPImagePickerConfiguration()
        
        config.screens = [.library, .photo]
        config.library.maxNumberOfItems = 5 - postImageData.count
        config.isScrollToChangeModesEnabled = true
        config.showsPhotoFilters = true
        config.onlySquareImagesFromCamera = false
        config.library.isSquareByDefault = false
        config.showsVideoTrimmer = true
        config.shouldSaveNewPicturesToAlbum = true
        config.albumName = "Necto"
        config.startOnScreen = YPPickerScreen.library
        config.showsCrop = .none
        config.bottomMenuItemSelectedTextColour = Constants.Colors.darkBrown
        config.colors.tintColor = Constants.Colors.darkBrown
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : Constants.Colors.darkBrown]
        UINavigationBar.appearance().tintColor = Constants.Colors.darkBrown
        
        let picker = YPImagePicker(configuration: config)
        
        picker.didFinishPicking { [unowned picker] items, _ in
            for item in items {
                switch item {
                case .photo(let photo):
                    self.postImageData.append(photo.image)
                    self.imagePreviewCollection.heightConstraint?.constant = 120
                    self.imagePreviewCollection.reloadData()
                
                case .video(let video):
                    print()
                }
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
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
extension NewPostVC: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postImageData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imagePreviewCollection.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomCell
        cell.backgroundColor = .clear
        cell.imageView.image = self.postImageData[indexPath.row]
        cell.postImageXButton.tag = indexPath.row
        cell.postImageXButton.addTarget(self, action: #selector(removeImageAction(sender: )), for: .touchUpInside)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 150, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    }
    @objc func removeImageAction(sender: UIButton) {
        self.postImageData.remove(at: sender.tag)
        imagePreviewCollection.reloadData()
        if postImageData.count <= 0
        {
            self.imagePreviewCollection.heightConstraint?.constant = 0
        }
    }
}
class CustomCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let postImageXButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        self.addSubview(imageView)
        
        postImageXButton.setImage( UIImage(systemName: "xmark.circle.fill"), for: .normal)
        postImageXButton.tintColor = Constants.Colors.mainText //.lightGray
        self.addSubview(postImageXButton)
        
        imageView.addAnchors(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
        imageView.backgroundColor = .yellow
        
        self.postImageXButton.addAnchors(top: self.imageView.topAnchor, leading: self.imageView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: -25, left: -25, bottom: 0, right: 0), size: .init(width: 50, height: 50))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
