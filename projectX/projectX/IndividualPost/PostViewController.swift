//
//  ViewController.swift
//  testing
//
//  Created by Radomyr Bezghin on 8/12/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit
import FirebaseFirestore

class PostViewController: UIViewController {
    
    private var customView: PostView?
    private var commentView: AddNewCommentView?
    private var commentViewBottomConstraint: NSLayoutConstraint?
    
    var comments: [Comment]?{
        didSet{
            commentsTableView.reloadData()
        }
    }
    var post: Post?
    
    private var commentsTableView: UITableView = {
        let tableview = UITableView()
        tableview.tableFooterView = UIView()
        tableview.backgroundColor = UIColor.init(red: 223/255.0, green: 230/255.0, blue: 233/255.0, alpha: 1.0)
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = post?.stationName
        setupTableView()
        setupViewWithPost()
        setupToolbar()
        setupKeyboardCommentView()
        addDissmissForCommentView()
        loadComments { [weak self](comments) in
            self?.comments = comments
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //navigationController?.setToolbarHidden(false, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.isToolbarHidden = true
    }
    private func addDissmissForCommentView(){
        commentView?.closeButton.addTarget(self, action: #selector(didTapDissmissNewComment), for: .touchUpInside)
    }
    @objc func didTapDissmissNewComment(){
        commentView?.commentTextView.endEditing(true)
    }
    
    //MARK: Keyboard notifications + comment view setup 
    private func setupKeyboardCommentView(){
        commentView = AddNewCommentView()
        commentView?.commentTextView.isScrollEnabled = true
        commentView?.isHidden = true
        commentView?.isUserInteractionEnabled = false
        commentView?.commentTextView.delegate = self
        guard let commentView = commentView else {return}
        view.addSubview(commentView)
        commentView.addAnchors(top: nil,
                                     leading: view.leadingAnchor,
                                     bottom: nil,
                                     trailing: view.trailingAnchor)
        commentViewBottomConstraint = commentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        commentViewBottomConstraint?.isActive = true
        textViewDidChange(commentView.commentTextView)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    private func setupViewWithPost(){
        guard let post = post else {return}
        customView?.authorUILabel.text = post.userInfo.name
        let date = post.date
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        customView?.dateUILabel.text = "\(formatter.string(from: date))"
        customView?.titleUILabel.text = post.title
        if post.imageURL != nil {
            let data = try? Data(contentsOf: post.imageURL!)
            if let imageData = data {
                customView?.postImageView.image = UIImage(data: imageData)
            }
        } else{
            customView?.imageHeightConstaint.constant = 0
        }
        customView?.bodyUILabel.text = post.text
        customView?.likesLabel.text = "\(post.likes)"
        customView?.layoutIfNeeded()
        
    }
    func loadComments(completion: @escaping (_ stations: [Comment]) -> Void){
        let basicQuery = Firestore.firestore().comments.whereField(FirestoreFields.postID.rawValue, isEqualTo: post?.id ?? "")
        var comments = [Comment]()
        basicQuery.getDocuments { (snapshot, error) in
            if let error = error {
                print ("I got an error retrieving comments: \(error)")
                return
            }
            guard let documents = snapshot?.documents else { return }
            comments = documents.compactMap { (querySnapshot) -> Comment? in
                return try? querySnapshot.data(as: Comment.self)
            }
            completion(comments)
        }
    }
    @objc private func keyboardWillShow(notification: NSNotification) {
        commentView?.isHidden = false
        commentView?.isUserInteractionEnabled = true
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            commentViewBottomConstraint?.constant = -keyboardHeight
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseInOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    @objc private func keyboardWillHide(notification: NSNotification) {
        commentView?.isHidden = true
        commentView?.isUserInteractionEnabled = false
        commentViewBottomConstraint?.constant = 0

    }

    //MARK: ToolBar setup and handlers
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
    @objc private func shareButtonPushed(){
        
    }
    @objc private func createCommentButtonPushed(){
        commentView?.commentTextView.becomeFirstResponder()
    }
    @objc private func writeButtonPushed(){
        
    }
    @objc private func bookmarkButtonPushed(){
        
    }
    @objc private func closeButtonPushed(){
        
    }
}
extension PostViewController: UITextViewDelegate{
    /// Handles resizing of the input text view.
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: commentView?.commentTextView.frame.width ?? 0.0, height: .infinity)
        guard let estimatedSize = commentView?.commentTextView.sizeThatFits(size) else {return}
        if (estimatedSize.height > (self.view.frame.height * 0.3)){
            commentView?.commentTextViewHeightConstraint?.constant = self.view.frame.height * 0.3
        } else{
            commentView?.commentTextViewHeightConstraint?.constant = estimatedSize.height
        }

    }
}
extension PostViewController: UITableViewDelegate, UITableViewDataSource{
    //MARK: TableView setup, delegates, layout
    private func setupTableView(){
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
        commentsTableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.cellID)
        commentsTableView.rowHeight = UITableView.automaticDimension
        commentsTableView.estimatedRowHeight = 150
        view.addSubview(commentsTableView)
        commentsTableView.addAnchors(top: view.safeAreaLayoutGuide.topAnchor,
                                     leading: view.leadingAnchor,
                                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     trailing: view.trailingAnchor)
        customView = PostView(frame: view.frame)
        customView?.translatesAutoresizingMaskIntoConstraints = false
        commentsTableView.tableHeaderView = customView
        commentsTableView.tableHeaderView?.layoutIfNeeded() //Without this autolayout doesnt update the custom view layout
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        commentView?.commentTextView.endEditing(true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.cellID, for: indexPath) as! CommentTableViewCell
        guard let comment = comments?[indexPath.row] else {fatalError("error loading comment")}
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

