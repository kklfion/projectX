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
        return view
    }()
    /// height of a comment view when in its default position
    let defaultCommentViewHeight = CGFloat(75)
    /// height of the comment view when editing
    let maxCommentViewHeight = CGFloat(300)
    
    ///bottom constaint is used for commentView to hide/slideout with the keyboard
    private var newCommentViewBottomConstraint: NSLayoutConstraint?
    
    ///height constaint is used for commentView to change height with the keyboard
    private var newCommentViewHeightConstraint: NSLayoutConstraint?
    
    ///tableview that will be populated with comments for current post
    private var commentsTableView: UITableView = {
        let tableview = UITableView()
        tableview.tableFooterView = UIView()
        tableview.backgroundColor = .white
        tableview.separatorStyle = .none
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
        view.backgroundColor = .white
        self.navigationItem.title = post.stationName
        print(post.id)
        
        //only this order works, some bug that makes newcommentview invisible if this is changed
        setupTableViewAndHeader()
        populatePostViewWithPost()
        setupNewCommentView()
        setupKeyboardnotifications()
        loadCommentsForPost()
    }
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
    private func setupNewCommentView(){
        newCommentView.commentTextView.delegate = self
        view.addSubview(newCommentView)
        newCommentView.addAnchors( top: nil,
                                leading: view.leadingAnchor,
                                bottom: nil,
                                trailing: view.trailingAnchor,
                                size: .init(width: 0, height: 0))
        
        newCommentViewHeightConstraint = newCommentView.heightAnchor.constraint(equalToConstant: defaultCommentViewHeight)
        newCommentViewHeightConstraint?.isActive = true
        newCommentViewBottomConstraint = newCommentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        newCommentViewBottomConstraint?.isActive = true
   
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
        postHeaderView?.authorLabel.text = post.userInfo.name
        NetworkManager.shared.getAsynchImage(withURL: post.userInfo.photoURL) { (image, error) in
            DispatchQueue.main.async {
                self.postHeaderView?.authorImageView.image = image
            }
        }
        
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
        postHeaderView?.commentsLabel.text = "\(post.commentCount)"
        postHeaderView?.layoutIfNeeded()
        
    }
}
//MARK: Handlers
extension PostViewController{
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            newCommentViewBottomConstraint?.constant = -keyboardHeight
            newCommentViewHeightConstraint?.constant = maxCommentViewHeight
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseInOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    @objc private func keyboardWillHide(notification: NSNotification) {
        newCommentViewBottomConstraint?.constant = 0
        newCommentViewHeightConstraint?.constant = defaultCommentViewHeight
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)

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
                if let error = error {
                    print(error)
                }
                else if document != nil{
                    user = document!
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
//MARK: TableView datasource, delegate
extension PostViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        newCommentView.commentTextView.endEditing(true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.cellID, for: indexPath) as! CommentCell
        let comment = comments[indexPath.row]
        NetworkManager.shared.getAsynchImage(withURL: comments[indexPath.row].userInfo.photoURL) { (image, error) in
            DispatchQueue.main.async {
                cell.authorImageView.image = image
            }
        }
        //cell.authorTitleLable.text = comment.userInfo.name
        cell.commentLabel.text = comment.text
        let date = comment.date
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        cell.dateTimeLabel.text = "\(formatter.string(from: date))"
        let likes = comment.likes
        cell.likesLabel.text  = "\(likes)"
        cell.authorLabel.text = comment.userInfo.name
        return cell
    }
}
//MARK: comment text view delegate
extension PostViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        slideOutNewCommentView(textView)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        foldInNewCommentView(textView)
    }
    func textViewDidChange(_ textView: UITextView) {
        
    }
    private func slideOutNewCommentView(_ textView: UITextView){
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
            textView.textAlignment = .left
        }
        newCommentView.commentTextView.becomeFirstResponder()
        newCommentView.bottomStack.isHidden = false
        newCommentView.topStack.isHidden = false
    }
    private func foldInNewCommentView(_ textView: UITextView){
        if textView.text.isEmpty {
            textView.text = newCommentView.commentPlaceholderMessage
            textView.textColor = UIColor.lightGray
            textView.textAlignment = .center
        }
        newCommentView.bottomStack.isHidden = true
        newCommentView.topStack.isHidden = true
        
        newCommentView.commentTextView.endEditing(true)
    }
}

