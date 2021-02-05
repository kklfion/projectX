//
//  SignUpViewController.swift
//  projectX
//
//  Created by Radomyr Bezghin on 7/19/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {
    lazy var signUpView = createSignUpView()
    var userPhotoURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/Avatars%2Fblank.png?alt=media&token=90cbe14e-9023-497d-bd5f-6c1b0803d848")
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign Up"
        view.backgroundColor = .white
        setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    /// after views are created draw a bottom line below the textLabels
    override func viewDidLayoutSubviews() {
        addBottomLine()
    }
    override func viewDidAppear(_ animated: Bool) {
        view.setNeedsLayout()
    }
    func createSignUpView()-> SignUpView{
        let view = SignUpView(frame: self.view.frame)
        view.signUpButton.addTarget(self, action: #selector(newUserSignUp), for: .touchUpInside)
        view.editButton.addTarget(self, action: #selector(openAvatarSelector), for: .touchUpInside)
        
        view.emailTextField.delegate = self
        view.passwordTextField.delegate = self
        view.nameTextField.delegate = self

        return view
        
    }
    func setupView(){
        view.addSubview(signUpView)
        
        let shadowRect = self.signUpView.profileImageViewContainer.layer.bounds
        
            self.signUpView.profileImageViewContainer.layer.masksToBounds = false
            self.signUpView.profileImageViewContainer.layer.shadowColor = UIColor.black.cgColor//Constants.Colors.mainYellow.cgColor
            self.signUpView.profileImageViewContainer.layer.shadowOpacity = 0.2
            self.signUpView.profileImageViewContainer.layer.shadowOffset = CGSize(width: -1, height: 1)
            self.signUpView.profileImageViewContainer.layer.shadowRadius = 10
            self.signUpView.profileImageViewContainer.layer.cornerRadius = 50
            self.signUpView.profileImageViewContainer.layer.shadowPath = UIBezierPath(roundedRect: shadowRect, cornerRadius: shadowRect.height / 2).cgPath
            //self.profileView?.profileImageViewContainer.layer.shadowPath = UIBezierPath(rect: (self.profileView?.profileImageViewContainer.layer.bounds)!).cgPath
            self.signUpView.profileImageViewContainer.layer.shouldRasterize = true
            self.signUpView.profileImageViewContainer.layer.rasterizationScale = UIScreen.main.scale
        
        //signUpView.userAvatar.applyShadowWithCorner(containerView: signUpView.avaterContainterView, cornerRadious: 60)
        self.addKeyboardTapOutGesture(target: self)
    }
    func addBottomLine(){
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: signUpView.emailTextField.frame.height - 1, width: signUpView.emailTextField.frame.width, height: 1.0)
        bottomLine.backgroundColor = Constants.Colors.darkBrown.cgColor
        signUpView.emailTextField.borderStyle = .none
        signUpView.emailTextField.layer.addSublayer(bottomLine)
        
        
        bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: signUpView.passwordTextField.frame.height - 1, width: signUpView.passwordTextField.frame.width, height: 1.0)
        bottomLine.backgroundColor = Constants.Colors.darkBrown.cgColor
        signUpView.passwordTextField.borderStyle = .none
        signUpView.passwordTextField.layer.addSublayer(bottomLine)
        
        bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: signUpView.nameTextField.frame.height - 1, width: signUpView.nameTextField.frame.width, height: 1.0)
        bottomLine.backgroundColor = Constants.Colors.darkBrown.cgColor
        signUpView.nameTextField.borderStyle = .none
        signUpView.nameTextField.layer.addSublayer(bottomLine)
    }
    @objc func openAvatarSelector(){
        print("choose avatar")
        let VC = SelectAvatarViewController()
        VC.delegate = self
        self.navigationController?.present(VC, animated: true, completion: nil)
        //present(SelectAvatarViewController(), animated: true, completion: nil)
    }
    func setNewImage(imageName: String, imageURL: String)
    {
        signUpView.userAvatar.image = UIImage(named: imageName)
        userPhotoURL = URL(string: imageURL) 
        print(userPhotoURL)
    }
    @objc func newUserSignUp(){
        //try creating a new account
        guard let email = signUpView.emailTextField.text else{return}
        guard let password = signUpView.passwordTextField.text else{return}
        guard let name = signUpView.nameTextField.text else{return}
        //check data in the fields
        let loginError = isEmailPasswordValid(rawEmail: email, rawPassword: password)
        if let loginError = loginError {
            displayLoginErrorMessage(message: loginError)
            print(loginError)
            return
        }
                
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
          // ...
            if let error = error{
                print(error)
                self.displayLoginErrorMessage(message: "Failed creating a new account.")
                return
            }else if let authResult = authResult{
                let newUser = User(name: name,
                                   photoURL: self.userPhotoURL,
                                   email: email,
                                   uid: String(authResult.user.uid))
                let db = Firestore.firestore()
                do {
                    try db.collection("users").document(authResult.user.uid).setData(from: newUser)
                } catch let error{
                    print("no new user for you: \(error)")
                }
            }
            //sending authentication email
            Auth.auth().currentUser!.sendEmailVerification {(error) in
                 if let error = error{
                    print(error)
                    self.displayLoginErrorMessage(message: "Failed in sending email")
                }
                 else{
                    self.displayLoginErrorMessage(message: "Email Verification sent!")
                    self.dismiss(animated: true)
                }
            }
        }
    }
    
    
    
    
    /// Checks if email & password are valid
    /// - Parameters:
    ///   - email: email to test
    ///   - password: password to test
    /// - Returns: returns an an error message if somewithing is invalid or nil if everything is correct
    func isEmailPasswordValid(rawEmail: String, rawPassword: String)-> String?{
//        let email = rawEmail.trimmingCharacters(in: .whitespacesAndNewlines)
//        let password = rawPassword.trimmingCharacters(in: .whitespacesAndNewlines)
//
//        if email.isEmpty{
//            return "Please, enter your email"
//        }else if password.isEmpty{
//             return "Please, enter your password"
//        }
//        //check email
//        //There’s some text before the @
//        //There’s ucsc.edu after the @
//        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+.edu"
//        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
//        if !pred.evaluate(with: email){
//            return "Please, use your .edu email"
//        }
//        // at least one uppercase,
//        // at least one digit
//        // at least one lowercase
//        // 8 characters total
//        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
//        if !passwordTest.evaluate(with: password){
//            let message = """
//            Invalid Password:
//            use at least 8 characters
//            at least one upper case
//            at least one lower case
//            at least one digit
//            """
//            return message
//        }
        return nil
    }
    func displayLoginErrorMessage(message: String){
        signUpView.errorLabel.text = message
    }

}
extension SignUpViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
