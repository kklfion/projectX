//
//  SignUpViewController.swift
//  projectX
//
//  Created by Radomyr Bezghin on 7/19/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    lazy var signUpView = createSignUpView()
    override func viewDidLoad() {
        super.viewDidLoad()
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
    func createSignUpView()-> SignUpView{
        let view = SignUpView(frame: self.view.frame)
        view.signUpButton.addTarget(self, action: #selector(newUserSignUp), for: .touchUpInside)
        return view
        
    }
    func setupView(){
        view.addSubview(signUpView)
        
    }
    func addBottomLine(){
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: signUpView.emailTextField.frame.height - 1, width: signUpView.emailTextField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.systemGreen.cgColor
        signUpView.emailTextField.borderStyle = .none
        signUpView.emailTextField.layer.addSublayer(bottomLine)
        
        bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: signUpView.passwordTextField.frame.height - 1, width: signUpView.passwordTextField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.systemGreen.cgColor
        signUpView.passwordTextField.borderStyle = .none
        signUpView.passwordTextField.layer.addSublayer(bottomLine)
        
        bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: signUpView.nameTextField.frame.height - 1, width: signUpView.nameTextField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.systemGreen.cgColor
        signUpView.nameTextField.borderStyle = .none
        signUpView.nameTextField.layer.addSublayer(bottomLine)
        
        bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: signUpView.lastTextField.frame.height - 1, width: signUpView.lastTextField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.systemGreen.cgColor
        signUpView.lastTextField.borderStyle = .none
        signUpView.lastTextField.layer.addSublayer(bottomLine)
    }

    @objc func newUserSignUp(){
        //try creating a new account
        guard let email = signUpView.emailTextField.text else{return}
        guard let password = signUpView.passwordTextField.text else{return}
        guard let name = signUpView.nameTextField.text else{return}
        guard let lastname = signUpView.lastTextField.text else{return}
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
                let db = Firestore.firestore()
                db.collection("users").addDocument(data: ["firstname": name, "lastname":lastname, "uid": authResult.user.uid]) { (error) in
                    
                }
            }
        }
        //transition to a new screen
        let vc = MainContainerVC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    /// Checks if email & password are valid
    /// - Parameters:
    ///   - email: email to test
    ///   - password: password to test
    /// - Returns: returns an an error message if somewithing is invalid or nil if everything is correct
    func isEmailPasswordValid(rawEmail: String, rawPassword: String)-> String?{
        let email = rawEmail.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = rawPassword.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if email.isEmpty{
            return "Please, enter your email"
        }else if password.isEmpty{
             return "Please, enter your password"
        }
        //check email
        //There’s some text before the @
        //There’s ucsc.edu after the @
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+.edu"
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        if !pred.evaluate(with: email){
            return "Please, use your .edu email"
        }
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        if !passwordTest.evaluate(with: password){
            let message = """
            Invalid Password:
            use at least 8 characters
            at least one upper case
            at least one lower case
            at least one digit
            """
            return message
        }
        return nil
    }
    func displayLoginErrorMessage(message: String){
        signUpView.errorLabel.text = message
    }

}
