//
//  ContactUsViewController.swift
//  projectX
//
//  Created by Gurpreet Dhillon on 1/26/21.
//  Copyright © 2021 Radomyr Bezghin. All rights reserved.
//

import Foundation
import UIKit

class ContactUsViewController: UIViewController {
    
    lazy var CUView = createContactUsView()
    
    lazy var contentView : UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    lazy var scrollView : UIScrollView = {
         let scrollView = UIScrollView(frame: .zero)
        scrollView.backgroundColor = Constants.Colors.mainBackground
         scrollView.bounces = true
         scrollView.translatesAutoresizingMaskIntoConstraints = false
         return scrollView
     }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Colors.mainBackground
        self.navigationController?.navigationBar.isHidden = true
        setupView()
        
    }
    func createContactUsView()-> ContactUsView{
        let view = ContactUsView(frame: self.view.frame)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.cancelButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        return view
    }
    
    
    ///scrollView<-contentView<-TOSView
    func setupView(){
        /*view.addSubview(scrollView)
        self.addKeyboardTapOutGesture(target: self)
        scrollView.addAnchors(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
      
        scrollView.addSubview(contentView)
        contentView.addAnchors(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor)
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        contentView.addSubview(CUView)
        CUView.addAnchors(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor)*/
        self.view.addSubview(CUView)
        CUView.addAnchors(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
    }
    
    @objc func dismissAction(_ sender:UIButton!) {
        dismiss(animated: true, completion: nil)
    }
}
