//
//  TermsOfServiceViewController.swift
//  projectX
//
//  Created by Gurpreet Dhillon on 1/25/21.
//  Copyright © 2021 Radomyr Bezghin. All rights reserved.
//

import Foundation
import UIKit

class TermsOfServiceViewController: UIViewController {
    
    lazy var TOSView = createTOSView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        setupView()
    }
    func createTOSView()-> TermsOfServiceView{
        let view = TermsOfServiceView(frame: self.view.frame)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.cancelButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        return view
    }
    
    
    func setupView(){
        view.addSubview(TOSView)
        self.addKeyboardTapOutGesture(target: self)
        TOSView.addAnchors(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
    
    @objc func dismissAction(_ sender:UIButton!) {
        dismiss(animated: true, completion: nil)
    }
}
