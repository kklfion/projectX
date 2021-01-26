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
    
    lazy var contentView : UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    lazy var scrollView : UIScrollView = {
         let scrollView = UIScrollView(frame: .zero)
         scrollView.backgroundColor = .white
         scrollView.bounces = true
         scrollView.translatesAutoresizingMaskIntoConstraints = false
         return scrollView
     }()

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
        view.addSubview(scrollView)
        self.addKeyboardTapOutGesture(target: self)
        scrollView.addAnchors(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
      
        scrollView.addSubview(contentView)
        contentView.addAnchors(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor)
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        contentView.addSubview(TOSView)
        TOSView.addAnchors(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor)
    }
    
    @objc func dismissAction(_ sender:UIButton!) {
        dismiss(animated: true, completion: nil)
    }
}
