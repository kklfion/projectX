//
//  LoginViewController.swift
//  projectX
//
//  Created by Radomyr Bezghin on 7/17/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    //let userManager = UserManager.shared
    
    lazy var loginView = createLoginView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        setupView()
    }
    override func viewDidLayoutSubviews() {
        addBottomLine()
    }
    func createLoginView()-> LoginView{
        let view = LoginView(frame: self.view.frame)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.registerButton.addTarget(self, action: #selector(signMeUp), for: .touchUpInside)
        view.loginButton.addTarget(self, action: #selector(logMeIn), for: .touchUpInside)
        view.skipButton.addTarget(self, action: #selector(skipToMain), for: .touchUpInside)
        view.emailTextField.delegate = self
        view.passwordTextField.delegate = self
        return view
    }
    func setupView(){
        view.addSubview(loginView)
        loginView.addAnchors(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
    /// draws a line belowe the email and password fields, has to be here because frame is not defined before subviews did layout
    func addBottomLine(){
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: loginView.emailTextField.frame.height - 1, width: loginView.emailTextField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.systemGreen.cgColor
        loginView.emailTextField.borderStyle = .none
        loginView.emailTextField.layer.addSublayer(bottomLine)
        
        bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: loginView.passwordTextField.frame.height - 1, width: loginView.passwordTextField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.systemGreen.cgColor
        loginView.passwordTextField.borderStyle = .none
        loginView.passwordTextField.layer.addSublayer(bottomLine)
    }
    /// instantiates a signUp view where user can create a new account
    @objc func signMeUp(){
        let signUpController = SignUpViewController()
        navigationController?.pushViewController(signUpController, animated: true)
    }
    /// Lets users to login into their accounts. Verifies correctness of the email/password and then check if it exists in the database. Errors are displayed on the screen.
    @objc func logMeIn(){
        guard let email = loginView.emailTextField.text else{return}
        guard let password = loginView.passwordTextField.text else{return}
        
        let loginError = isEmailPasswordValid(rawEmail: email, rawPassword: password)
        if let loginError = loginError {
            displayLoginErrorMessage(message: loginError)
            print(loginError)
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if !Auth.auth().currentUser!.isEmailVerified{
                self?.displayLoginErrorMessage(message: "Email not verified")
                return
            }
           else if  error != nil {
                print(error?.localizedDescription ?? "error")
                self?.displayLoginErrorMessage(message: "User was not found. Please, try again.")
                return
            }else{
                guard let id = Auth.auth().currentUser?.uid else {return}
                UserManager.shared().loadDataFor(userID: id)
                if self?.presentingViewController is SettingsTableViewController{
                    self?.dismiss(animated: true)
                }else{
                    self?.dismiss(animated: true)
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
        let email = rawEmail.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = rawPassword.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if email.isEmpty{
            return "Please, enter your email"
        }else if password.isEmpty{
             return "Please, enter your password"
        }
        return nil
    }
    func displayLoginErrorMessage(message: String){
        loginView.errorLabel.text = message
    }
    /// Users have an option to skip logging into their accounts.
    @objc func skipToMain(){
        self.dismiss(animated: true)
    }
}
extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
