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

    let signupView = SignUpView()
    
    override func loadView() {
        signupView.signUpButton.addTarget(self, action: #selector(newUserSignUp), for: .touchUpInside)
        view = signupView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    override func viewDidLayoutSubviews() {
        addBottomLine()
    }
    func addBottomLine(){
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: signupView.emailTextField.frame.height - 1, width: signupView.emailTextField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.systemGreen.cgColor
        signupView.emailTextField.borderStyle = .none
        signupView.emailTextField.layer.addSublayer(bottomLine)
        
        bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: signupView.passwordTextField.frame.height - 1, width: signupView.passwordTextField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.systemGreen.cgColor
        signupView.passwordTextField.borderStyle = .none
        signupView.passwordTextField.layer.addSublayer(bottomLine)
        
        bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: signupView.nameTextField.frame.height - 1, width: signupView.nameTextField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.systemGreen.cgColor
        signupView.nameTextField.borderStyle = .none
        signupView.nameTextField.layer.addSublayer(bottomLine)
        
        bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: signupView.lastTextField.frame.height - 1, width: signupView.lastTextField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.systemGreen.cgColor
        signupView.lastTextField.borderStyle = .none
        signupView.lastTextField.layer.addSublayer(bottomLine)
        
        
    }
    
    @objc func newUserSignUp(){
        //check data in the fields
        
        //try creating a new account
        guard let email = signupView.emailTextField.text else{return}
        guard let password = signupView.passwordTextField.text else{return}
        guard let name = signupView.nameTextField.text else{return}
        guard let lastname = signupView.lastTextField.text else{return}
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
          // ...
            if let error = error{
                print(error)
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

}