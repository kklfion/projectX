//
//  ViewController.swift
//  testing
//
//  Created by Radomyr Bezghin on 8/12/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class PostViewController: UIViewController {
    
    ///post is initialized by presenting controller
    private var post: Post
    
    ///comments for post
    private var comments = [Comment] ()
    
    ///header view for the post table view will be initialized with frame
    private var postHeaderView: PostView?

    ///view for adding a new comment, is hidden by default and is shown when keyboard appears
    private var newCommentView: NewCommentView = {
        let view = NewCommentView()
        view.commentTextView.isScrollEnabled = true
        view.isHidden = true
        view.isUserInteractionEnabled = false
        return view
    }()
    
    ///bottom constaint is used for commentView to hide/slideout with the keyboard
    private var newCommentViewBottomConstraint: NSLayoutConstraint?
    
    ///tableview that will be populated with comments for current post
    private var commentsTableView: UITableView = {
        let tableview = UITableView()
        tableview.tableFooterView = UIView()
        tableview.backgroundColor = UIColor.init(red: 223/255.0, green: 230/255.0, blue: 233/255.0, alpha: 1.0)
        return tableview
    }()
    
    ///to create postViewController post MUST be initialized
    init(post: Post){
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        extendedLayoutIncludesOpaqueBars = true
        view.backgroundColor = .white
        self.navigationItem.title = post.stationName
        
        //only this order works, some bug that makes newcommentview invisible if this is changed
        setupTableViewAndHeader()
        populatePostViewWithPost()
        setupToolbar()
        setupNewCommentView()
        setupKeyboardnotifications()
        loadCommentsForPost()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.isToolbarHidden = true
    }
    private func setupNewCommentView(){
        newCommentView.commentTextView.delegate = self
        view.addSubview(newCommentView)
        newCommentView.addAnchors( top: nil,
                                leading: view.leadingAnchor,
                                bottom: nil,
                                trailing: view.trailingAnchor)
        newCommentViewBottomConstraint = newCommentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        newCommentViewBottomConstraint?.isActive = true
        //to get current size
        textViewDidChange(newCommentView.commentTextView)
        //linking buttons
        newCommentView.closeButton.addTarget(self, action: #selector(didTapDissmissNewComment), for: .touchUpInside)
        newCommentView.sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
    }
    ///enables notifications when keyboards shows up/ hides
    private func setupKeyboardnotifications(){

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    private func populatePostViewWithPost(){
        postHeaderView?.authorUILabel.text = post.userInfo.name
        let date = post.date
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        postHeaderView?.dateUILabel.text = "\(formatter.string(from: date))"
        postHeaderView?.titleUILabel.text = post.title
        if post.imageURL != nil {
            let data = try? Data(contentsOf: post.imageURL!)
            if let imageData = data {
                postHeaderView?.postImageView.image = UIImage(data: imageData)
            }
        } else{
            postHeaderView?.imageHeightConstaint.constant = 0
        }
        postHeaderView?.bodyUILabel.text = post.text
        postHeaderView?.likesLabel.text = "\(post.likes)"
        postHeaderView?.layoutIfNeeded()
        
    }
    //TODO: this will be replaced in the update
    private func setupToolbar(){
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up")?.withTintColor(.black, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(shareButtonPushed))
        let commentButton = UIBarButtonItem(image: UIImage(systemName: "text.bubble")?.withTintColor(.black, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(createCommentButtonPushed))
        let writeButton = UIBarButtonItem(image: UIImage(systemName: "pencil")?.withTintColor(.black, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(writeButtonPushed))
        let bookmarkButton = UIBarButtonItem(image: UIImage(systemName: "bookmark")?.withTintColor(.black, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(bookmarkButtonPushed))
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark")?.withTintColor(.black, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(closeButtonPushed))
        self.toolbarItems = [shareButton,flexibleSpace,commentButton,flexibleSpace,writeButton,flexibleSpace,bookmarkButton, flexibleSpace ,closeButton]
        navigationController?.setToolbarHidden(false, animated: true)
    }
}
//MARK: Handlers
extension PostViewController{
    @objc private func keyboardWillShow(notification: NSNotification) {
        newCommentView.isHidden = false
        newCommentView.isUserInteractionEnabled = true
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            newCommentViewBottomConstraint?.constant = -keyboardHeight
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseInOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    @objc private func keyboardWillHide(notification: NSNotification) {
        newCommentView.isHidden = true
        newCommentView.isUserInteractionEnabled = false
        newCommentViewBottomConstraint?.constant = 0

    }
    @objc func didTapDissmissNewComment(){
        newCommentView.commentTextView.endEditing(true)
    }
    @objc func didTapSendButton(){
        if let user = Auth.auth().currentUser{
            writeCommentToDB(userID: user.uid,
                             text: newCommentView.commentTextView.text ?? "",
                             isAnonimous: newCommentView.anonimousSwitch.isOn)
        } else {
            let presenter = AlertPresenter(message: "You need to sign in") {
                self.dismiss(animated: true)
            }
            presenter.present(in: self)
        }
    }
    //TODO: this will be replaced in the update
    @objc private func shareButtonPushed(){
        
    }
    @objc private func createCommentButtonPushed(){
        newCommentView.commentTextView.becomeFirstResponder()
    }
    @objc private func writeButtonPushed(){
        
    }
    @objc private func bookmarkButtonPushed(){
        
    }
    @objc private func closeButtonPushed(){
        
    }
}
//MARK: Networking
extension PostViewController{
    ///send to the global queue to get user and waits for that data to create a comment.
    ///Comment is then sent to the db, upon success adds a comment to the tableview and refreshes it
    private func writeCommentToDB(userID: String, text: String, isAnonimous: Bool? = false){
        if text.count < 1 {
            let presenter = AlertPresenter(message: "Your comment is empty!") {
                self.dismiss(animated: true)
            }
            presenter.present(in: self)
            return
        }
        //move it to global so that group.wait doesnt make thread stuck
        DispatchQueue.global(qos: .userInitiated).async {
            var user: User?
            var comment: Comment?
            let group = DispatchGroup()
            //load user
            group.enter()
            NetworkManager.shared.getDocumentForID(collection: .users, uid: userID) { (document: User?, error) in
                if document != nil{
                    user = document!
                }else {
                    print(error ?? "Error loading user")
                }
                group.leave()
            }
            let result = group.wait(timeout: .now() + 5.0)
            switch result{
            case .success:
                guard let user = user else {return}
                comment = Comment(postID: self.post.id ?? "", userInfo: user, text: text, likes: 0, date: Date(), isAnonymous: isAnonimous)
                NetworkManager.shared.writeDocumentsWith(collectionType: .comments, documents: [comment]) { (error) in
                    if error != nil {
                        print(error ?? "error sending comment")
                        DispatchQueue.main.sync {
                            let presenter = AlertPresenter(message: "Connectivity issues, maybe try again!") {
                                self.dismiss(animated: true)
                            }
                            presenter.present(in: self)
                        }
                    }else{
                        DispatchQueue.main.sync {
                            self.comments.append(comment!)
                            self.commentsTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                        }
                    }
                    DispatchQueue.main.sync {
                        self.didTapDissmissNewComment()
                    }
                }
            case .timedOut:
                let presenter = AlertPresenter(message: "Connectivity issues, maybe try again!") {
                    self.dismiss(animated: true)
                }
                DispatchQueue.main.sync {
                    presenter.present(in: self)
                    self.didTapDissmissNewComment()
                }
            }
            
        }
    }
    func loadCommentsForPost(){
        let basicQuery = NetworkManager.shared.db.comments.whereField(FirestoreFields.postID.rawValue, isEqualTo: post.id ?? "")
        NetworkManager.shared.getDocumentsForQuery(query: basicQuery) { (comments: [Comment]?, error) in
            if comments != nil {
                self.comments = comments!
                self.commentsTableView.reloadData()
            }else{
                print(error ?? "error locading comments")
            }
        }
    }
}
//MARK: TableView setup, delegates, layout
extension PostViewController: UITableViewDelegate, UITableViewDataSource{
    private func setupTableViewAndHeader(){
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
        commentsTableView.register(CommentCell.self, forCellReuseIdentifier: CommentCell.cellID)
        commentsTableView.rowHeight = UITableView.automaticDimension
        commentsTableView.estimatedRowHeight = 150
        view.addSubview(commentsTableView)

        commentsTableView.addAnchors(top: view.safeAreaLayoutGuide.topAnchor,
                                     leading: view.leadingAnchor,
                                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     trailing: view.trailingAnchor)
        
        postHeaderView = PostView(frame: view.frame)
        postHeaderView?.translatesAutoresizingMaskIntoConstraints = false
        commentsTableView.tableHeaderView = postHeaderView
        commentsTableView.tableHeaderView?.layoutIfNeeded() //Without this autolayout doesnt update the custom view layout
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        newCommentView.commentTextView.endEditing(true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.cellID, for: indexPath) as! CommentCell
        let comment = comments[indexPath.row]
        cell.authorTitleLable.text = comment.userInfo.name
        cell.commentLabel.text = comment.text
        let date = comment.date
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        cell.dateTimeLabel.text = "\(formatter.string(from: date))"
        let likes = comment.likes
        cell.likesLabel.text  = "\(likes)"
        cell.extraTitleImageView.image = UIImage(systemName: comment.userInfo.titleImage ?? "")
        cell.optionalAuthorExtraTitle.text = comment.userInfo.title
        return cell
    }
}
extension PostViewController: UITextViewDelegate{
    /// Handles resizing of the input text view.
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: newCommentView.commentTextView.frame.width, height: .infinity)
        let estimatedSize = newCommentView.commentTextView.sizeThatFits(size)
        if (estimatedSize.height > (self.view.frame.height * 0.3)){
            newCommentView.commentTextViewHeightConstraint?.constant = self.view.frame.height * 0.3
        } else{
            newCommentView.commentTextViewHeightConstraint?.constant = estimatedSize.height
        }

    }
}

