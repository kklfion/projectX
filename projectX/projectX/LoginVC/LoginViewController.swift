//
//  LoginViewController.swift
//  projectX
//
//  Created by Radomyr Bezghin on 7/17/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    let loginView: LoginView = {
        let view = LoginView()
        //view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func loadView() {
        view = loginView
        addActionsToButtons()

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
       
    }
    override func viewDidLayoutSubviews() {
        addBottomLine()
    }
    /// adds actions to the buttons in the loginView
    func addActionsToButtons(){
        loginView.registerButton.addTarget(self, action: #selector(signMeUp), for: .touchUpInside)
        loginView.loginButton.addTarget(self, action: #selector(logMeIn), for: .touchUpInside)
        loginView.skipButton.addTarget(self, action: #selector(skipToMain), for: .touchUpInside)
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
    /// instantiates a signUp view where user cna create a new account
    @objc func signMeUp(){
        let signUpController = SignUpViewController()
        navigationController?.pushViewController(signUpController, animated: true)
    }
    /// Lets users to login into their accounts. Verifies correctness of the email/password and then check if it exists in the database. Errors are displayed on the screen.
    @objc func logMeIn(){
        guard let email = loginView.emailTextField.text else{return}
        guard let password = loginView.passwordTextField.text else{return}
        
        let loginError = isEmailPasswordValid(email: email, password: password)
        if let loginError = loginError {
            displayLoginErrorMessage(message: loginError)
            print(loginError)
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
          // ...
            if  error != nil {
                print(error?.localizedDescription ?? "error")
                self?.displayLoginErrorMessage(message: "User was not found. Please, try again.")
                return
            }else{
                
            }
            //transition to a new screen
            let vc = MainContainerVC()
            vc.modalPresentationStyle = .fullScreen
            self?.present(vc, animated: true)
        }
    }
    /// Checks if email & password are valid
    /// - Parameters:
    ///   - email: email to test
    ///   - password: password to test
    /// - Returns: returns an an error message if somewithing is invalid or nil if everything is correct
    func isEmailPasswordValid(email: String, password: String)-> String?{
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
            Use at least 8 characters
            at least one upper case
            at least one lower case
            at least one digit
            """
            return message
        }
        return nil
    }
    func displayLoginErrorMessage(message: String){
        loginView.errorLabel.text = message
    }
    /// Users have an option to skip logging into their accounts.
    @objc func skipToMain(){
        let vc = MainContainerVC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    


}
