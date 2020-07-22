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
    
    let loginView = LoginView()
    
    override func loadView() {
        loginView.registerButton.addTarget(self, action: #selector(signMeUp), for: .touchUpInside)
        loginView.loginButton.addTarget(self, action: #selector(logMeIn), for: .touchUpInside)
        loginView.skipButton.addTarget(self, action: #selector(skipToMain), for: .touchUpInside)
        view = loginView
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
    @objc func signMeUp(){
        let signUpController = SignUpViewController()
        navigationController?.pushViewController(signUpController, animated: true)
    }
    @objc func logMeIn(){
        guard let email = loginView.emailTextField.text else{return}
        guard let password = loginView.passwordTextField.text else{return}
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
          // ...
            if  error != nil {
                print(error?.localizedDescription ?? "error")
                return
            }else{
                
            }
            //transition to a new screen
            let vc = MainContainerVC()
            vc.modalPresentationStyle = .fullScreen
            self?.present(vc, animated: true)
        }
    }
    @objc func skipToMain(){
        let vc = MainContainerVC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    


}
