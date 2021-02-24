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
import Combine

///user can like post inside the post vc and that should be updated in the feed, also comment count can change
protocol DidUpdatePostAfterDissmissingDelegate: class {
    func updatePostModelInTheFeed(_ indexPath: IndexPath, post: Post, like: Like?, status: LikeStatus)
}
///to help figure out whether like was changed inside of the post and if Feed will need to update like in the database
enum LikeStatus{
    case add
    case delete
    case unchanged
}

class PostViewController: UIViewController {
    
    ///post is initialized by presenting controller
    private var post: Post
    
    private var user: User? {
        didSet{
            if user != nil {
                NetworkManager.shared.getAsynchImage(withURL: user?.photoURL, completion: { (image, error) in
                    if let image = image{
                        DispatchQueue.main.async {
                            self.userImage = image
                        }
                    }
                })
            }
        }
    }
    
    private var userImage: UIImage? {
        didSet {
            newCommentView.authorView.image = userImage
        }
    }
    
    private var userSubscription: AnyCancellable!
    
    ///is post liked by the user
    private var like: Like?
    
    private var likeStatus: LikeStatus = .unchanged
    
    ///used to update data in the feed when view is dissmissed
    private var indexPath: IndexPath
    
    ///user can like post inside the post vc and that should be updated in the feed, also comment count can change
    weak var updatePostDelegate: DidUpdatePostAfterDissmissingDelegate?
    
    ///comments for post
    private var comments = [Comment]()
    
    ///likes for the comments
    private var likesDictionary = [Comment: Like]()
    
    ///personal data about each user
    private var usersToComments = [Comment: User]()
    
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
        tableview.backgroundColor = Constants.Colors.mainBackground
        tableview.separatorStyle = .none
        return tableview
    }()
    
    ///to create postViewController post MUST be initialized
    init(post: Post, like: Like?, indexPath: IndexPath){
        self.post = post
        self.like = like
        self.indexPath = indexPath
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.Colors.mainBackground
        self.navigationItem.title = post.stationName
        navigationItem.largeTitleDisplayMode = .never

        //only this order works, some bug that makes newcommentview invisible if this is changed
        setupTableViewAndHeader()
        populatePostViewWithPost()
        setupNewCommentView()
        setupKeyboardnotifications()
        DispatchQueue.global(qos: .userInitiated).async {
            self.loadAdditionalPostData()
        }
        switch UserManager.shared().state {
        case .signedIn(let user):
            self.user = user
        default:
            userSubscription = UserManager.shared().userPublisher.sink { (user) in
                self.user = user
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    ///when dismissing the view, need to update data in the Feed
    override func viewWillDisappear(_ animated: Bool) {
        updateFeed()
    }
    private func updateFeed(){
        post.commentCount = comments.count
        if let like = like {
            switch likeStatus {
            case .delete: //if we have like and status is to delete - need to delete it
                updatePostDelegate?.updatePostModelInTheFeed(indexPath, post: post, like: like, status: .delete)
            default: //do nothing
                updatePostDelegate?.updatePostModelInTheFeed(indexPath, post: post, like: like, status: .unchanged)
            }
        } else { //if there is no like and status is to add it need to add a new like
            switch likeStatus {
            case .add: //if there was no like give from feed and we need to add a like
                updatePostDelegate?.updatePostModelInTheFeed(indexPath, post: post, like: like, status: .add)
            default:
                updatePostDelegate?.updatePostModelInTheFeed(indexPath, post: post, like: like, status: .unchanged)
            }
        }
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
                                     bottom: view.bottomAnchor,
                                     trailing: view.trailingAnchor,
                                     padding: .init(top: 0, left: 0, bottom: defaultCommentViewHeight, right: 0))
        
        postHeaderView = PostView(frame: view.frame)
        postHeaderView?.translatesAutoresizingMaskIntoConstraints = false
        postHeaderView?.delegate = self
        postHeaderView?.isLiked = like != nil ? true : false
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
        newCommentView.anonimousSwitch.addTarget(self, action: #selector(switchValueDidChange), for: .valueChanged)
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
        //postHeaderView?.authorUILabel.text = post.userInfo.name
        let date = post.date
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        postHeaderView?.dateUILabel.text = "\(formatter.string(from: date))"
        postHeaderView?.titleUILabel.text = post.title
        if !post.isAnonymous{
            postHeaderView?.authorUILabel.text = post.userInfo.name
            postHeaderView?.authorLabel.text = post.userInfo.name
            NetworkManager.shared.getAsynchImage(withURL: post.userInfo.photoURL) { (image, error) in
                DispatchQueue.main.async {
                    self.postHeaderView?.authorImageView.image = image
                }
            }
            postHeaderView?.authorLabel.isUserInteractionEnabled = true
            postHeaderView?.authorImageView.isUserInteractionEnabled = true
        } else {
            postHeaderView?.setAnonymousUser()
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
        guard let text = newCommentView.commentTextView.text else {
            newCommentView.commentTextView.endEditing(true)
            return
        }
        if !text.isEmpty {
            let alert = ConfirmationPresenter(question: "Discard uncommited comment?", acceptTitle: "Yes", rejectTitle: "No") { (choice) in
                switch choice {
                case .accepted:
                    self.newCommentView.commentTextView.endEditing(true)
                    self.newCommentView.setCommentViewDefaltMessage()
                case .rejected:
                    print("continue")
                }
            }
            alert.present(in: self)
        } else {
            newCommentView.commentTextView.endEditing(true)
        }
        
    }
    @objc func didTapSendButton(){
        switch UserManager.shared().state {
        case .signedIn(let user):
            guard let userID = user.id else {return}
            writeCommentToDB(userID: userID,
                            text: newCommentView.commentTextView.text ?? "",
                            isAnonimous: newCommentView.anonimousSwitch.isOn)
            newCommentView.setCommentViewDefaltMessage()
        default :
            let presenter = AlertPresenter(message: "You need to sign in") {
                self.dismiss(animated: true)
            }
            presenter.present(in: self)
        }
    }
    @objc func switchValueDidChange(){
        if newCommentView.anonimousSwitch.isOn {
            newCommentView.setAnonimousImage()
        } else {
            NetworkManager.shared.getAsynchImage(withURL: user?.photoURL, completion: { (image, error) in
                if let image = image{
                    DispatchQueue.main.async {
                        self.newCommentView.authorView.image = image
                    }
                }
            })
                
        }
    }
}
//MARK: Networking
extension PostViewController{
    ///send to the global queue to get user and waits for that data to create a comment.
    ///Comment is then sent to the db, upon success adds a comment to the tableview and refreshes it
    private func writeCommentToDB(userID: String, text: String, isAnonimous: Bool){
        if text.count < 1 {
            let presenter = AlertPresenter(message: "Your comment is empty!") {
                self.dismiss(animated: true)
            }
            presenter.present(in: self)
            return
        }
        var comment = Comment(postID: self.post.id ?? "", userID: userID, text: text, likes: 0, date: Date(), isAnonymous: isAnonimous)
        NetworkManager.shared.writeDocumentReturnReference(collectionType: .comments, document: comment) { (ref, error) in
            if error != nil {
                print(error ?? "error sending comment")
                DispatchQueue.main.async {
                    let presenter = AlertPresenter(message: "Connectivity issues, maybe try again!") {
                        self.dismiss(animated: true)
                    }
                    presenter.present(in: self)
                }
            }else if let ref = ref{
                //increment the number of comments
                NetworkManager.shared.incrementDocumentValue(collectionType: .posts,
                                                             documentID: self.post.id ?? "",
                                                             value: Double(1),
                                                             field: .commentCount)
                comment.id = ref

                self.post.commentCount += 1
                self.postHeaderView?.commentsLabel.text = "\(self.post.commentCount)"
                self.comments.insert(comment, at: 0)
                DispatchQueue.global(qos: .userInitiated).async {
                    self.loadUsers(for: [comment]) {
                        DispatchQueue.main.async {
                            self.commentsTableView.reloadData()
                        }
                    }
                }

            }
            DispatchQueue.main.async {
                self.newCommentView.commentTextView.endEditing(true)
            }
        }
    }
    private func loadAdditionalPostData(){
        let group = DispatchGroup()
        //1. load comments
        group.enter()
        loadComments {
            group.leave()
        }
        group.wait()
        //2. for every comment load  user
        group.enter()
        loadUsers(for: comments) {
            group.leave()
        }
        group.enter()
        loadLikes(for: comments){
            group.leave()
        }
        group.wait()
        DispatchQueue.main.async {
            self.commentsTableView.reloadData()
        }
    }
    private func loadComments(completion: @escaping () -> Void){
        let basicQuery = NetworkManager.shared.db.comments.whereField(FirestoreFields.postID.rawValue, isEqualTo: post.id ?? "").order(by: "likes", descending: true)
        NetworkManager.shared.getDocumentsForQuery(query: basicQuery) { (comments: [Comment]?, error) in
            if comments != nil {
                self.comments = comments!
                self.commentsTableView.reloadData()
            }else{
                print(error ?? "error locading comments")
            }
            completion()
        }
    }
    private func loadUsers(for comments: [Comment], completion: @escaping () -> Void){
        let group = DispatchGroup()
        for comment in comments {
            group.enter()
            NetworkManager.shared.getDocumentForID(collection: .users, uid: comment.userID) { (user: User?, err) in
                if let error = err {
                    print(error)
                } else if let user = user {
                    self.usersToComments[comment] = user
                }
                group.leave()
                
            }
        }
        group.wait()
        completion()
    }
    private func loadLikes(for comments: [Comment], completion: @escaping () -> Void){
        let group = DispatchGroup()
        for comment in comments {
            group.enter()
            guard let  id = comment.id else {continue}
            let query = NetworkManager.shared.db.likedPosts
                .whereField(FirestoreFields.postID.rawValue, isEqualTo: id)
                .whereField(FirestoreFields.userID.rawValue, isEqualTo: comment.userID)
            NetworkManager.shared.getDocumentsForQuery(query: query) { (likedPosts: [Like]?, error) in
                if error != nil {
                    print("error loading liked post", error!)
                }else if likedPosts != nil {
                    self.likesDictionary[comment] = likedPosts![0]
                }
                group.leave()
            }
        }
        group.wait()
        completion()
    }
    private func writeLikeToTheFirestore(with indexPath: IndexPath) {
        let userID = comments[indexPath.item].userID
        guard let commentID = comments[indexPath.item].id else {return}
        var document = Like(userID: userID, postID: commentID)
        NetworkManager.shared.writeDocumentReturnReference(collectionType: .likedPosts, document: document  ) { (ref, error) in
            if let err = error{
                print("Error creating like \(err)")
            } else { //need to increment likes in the post
                NetworkManager.shared.incrementDocumentValue(collectionType: .comments,
                                                             documentID: commentID,
                                                             value: Double(1),
                                                             field: .likes)
                document.id = ref
                self.likesDictionary[self.comments[indexPath.item]] = document
            }
        }
    }
    private func deleteLikeFromFirestore(with indexPath: IndexPath){
        //let comment = comments[indexPath.item]
        //let likedP = likesDictionary[comment]
        guard let likedPost = likesDictionary[comments[indexPath.item]] else {return}
        guard let docID = likedPost.id else {return}
        guard let commentID = comments[indexPath.item].id else {return}
        likesDictionary.removeValue(forKey: self.comments[indexPath.item])
        NetworkManager.shared.deleteDocumentsWith(collectionType: .likedPosts,
                                                  documentID: docID) { (error) in
            if error != nil{
                print("error disliking", error!)
            }else{
                NetworkManager.shared.incrementDocumentValue(collectionType: .comments,
                                                             documentID: commentID,
                                                             value: Double(-1),
                                                             field: .likes)
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
        cell.delegate = self
        cell.indexPath = indexPath
        let comment = comments[indexPath.row]
        guard let user = usersToComments[comment] else {return UITableViewCell()}
        if !comment.isAnonymous {
            NetworkManager.shared.getAsynchImage(withURL: user.photoURL) { (image, error) in
                DispatchQueue.main.async {
                    cell.authorImageView.image = image
                }
            }
            cell.authorLabel.text = user.name
            cell.authorLabel.isUserInteractionEnabled = true
            cell.authorImageView.isUserInteractionEnabled = true
        } else {
            cell.authorLabel.text = "Anonymous"
            cell.authorImageView.image = (UIImage(systemName: "person.crop.circle.fill")?.withTintColor(Constants.Colors.darkBrown, renderingMode: .alwaysOriginal))
            cell.authorLabel.isUserInteractionEnabled = false
            cell.authorImageView.isUserInteractionEnabled = false
        }

        cell.commentLabel.text = comment.text
        cell.dateTimeLabel.text = comment.date.diff()
        let likes = comment.likes
        cell.likesLabel.text  = "\(likes)"
        if likesDictionary[comment] != nil {
            cell.isLiked = true
        }else{
            cell.isLiked = false
        }
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
        if textView.textColor == Constants.Colors.subText {
            textView.text = nil
            textView.textColor = Constants.Colors.mainText
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
extension PostViewController: PostViewButtonsDelegate{
    func didTapLikeButton() {
        guard let header = postHeaderView else {return}
        postHeaderView?.isLiked.toggle()
        if header.isLiked{
            //1. change UI
            postHeaderView?.changeCellToLiked()
            //2. change locally
            post.likes += 1
            //3. set like status
            likeStatus = .add
        } else{
            //1. change UI
            header.changeCellToDisliked()
            //2. change locally
            post.likes -= 1
            //3. set like status
            likeStatus = .delete
        }
    }
    func didTapAuthorLabel() {
        presentAuthorFor(user: post.userInfo)
    }
    private func presentAuthorFor(user: User){
        let vc = OtherProfileViewController(user: user)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension PostViewController: CommentCellTapableDelegate{
    func didTapLikeButton(_ indexPath: IndexPath, _ cell: CommentCell) {
        cell.isLiked.toggle()
        if cell.isLiked{
            //1. change UI
            cell.changeCellToLiked()
            //2. change locally
            comments[indexPath.item].likes += 1
            //3. change in the DB
            writeLikeToTheFirestore(with: indexPath)
        } else{
            //1. change UI
            cell.changeCellToDisliked()
            //2. change locally
            comments[indexPath.item].likes -= 1
            //3. change in the DB
            deleteLikeFromFirestore(with: indexPath)
        }
    }
    
    func didTapAuthorLabel(_ indexPath: IndexPath) {
        guard let user = usersToComments[comments[indexPath.item]] else {return}
        presentAuthorFor(user: user)
    }
    
    
}

