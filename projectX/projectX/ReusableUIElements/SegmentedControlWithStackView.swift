//
//  StackViewWithTwoTableViews.swift
//  projectX
//
//  Created by Radomyr Bezghin on 10/17/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

///must be init with frame
class SegmentedControlWithStackView: UIView{
    required init(frame: CGRect, itemNames: [String]) {
        self.numberOfItems = itemNames.count
        self.itemNames = itemNames
        super.init(frame: frame)
        setupViews()
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let numberOfItems: Int

    var itemNames: [String]{
        didSet{
            leftButton.setTitle(itemNames.first, for: .normal)
            rightButton.setTitle(itemNames[1], for: .normal)
        }
    }
    
    let leftButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = Constants.bodyTextFont
        button.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        return button
    }()
    let rightButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = Constants.bodyTextFont
        button.addTarget(self, action: #selector(didTapRightButton), for: .touchUpInside)
        return button
    }()
    let slidingThingy: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.clipsToBounds = true
        return view
    }()
    func setSlidingThingyColor(color: UIColor){
        slidingThingy.backgroundColor = color
    }
    
    @objc func didTapLeftButton(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut,
            animations:{
                self.leftAxis?.isActive = true
                self.rightAxis?.isActive = false
                self.stackView.transform = .identity
                self.layoutIfNeeded()
            }, completion: nil)
    }
    @objc func didTapRightButton(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut,
            animations:{
                self.leftAxis?.isActive = false
                self.rightAxis?.isActive = true
                self.stackView.transform = CGAffineTransform(translationX: -self.frame.width, y: 0)
                self.layoutIfNeeded()
            }, completion: nil)
    }
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        return stack
    }()
    
    var leftAxis: NSLayoutConstraint?
    var rightAxis: NSLayoutConstraint?

    private func setupViews(){
        leftButton.setTitle(itemNames.first, for: .normal)
        rightButton.setTitle(itemNames[1], for: .normal)
        self.addSubview(stackView)
        let  buttonsStack = UIStackView(arrangedSubviews: [leftButton, rightButton])
        buttonsStack.axis = .horizontal
        buttonsStack.distribution = .fillEqually
        self.addSubview(buttonsStack)
        self.addSubview(slidingThingy)
        
        buttonsStack.addAnchors(top: self.topAnchor,
                                     leading: self.leadingAnchor,
                                     bottom: nil,
                                     trailing: self.trailingAnchor,
                                     padding: .init(top: 0, left: 10, bottom: 0, right: 10),
                                     size: .init(width: 0, height: 0))
        slidingThingy.addAnchors(top: buttonsStack.bottomAnchor,
                                 leading: nil,
                                 bottom: nil,
                                 trailing: nil,
                                 size: .init(width: 20, height: 2.5))
        slidingThingy.layer.cornerRadius = 2
        leftAxis =  slidingThingy.centerXAnchor.constraint(equalTo: leftButton.centerXAnchor)
        rightAxis = slidingThingy.centerXAnchor.constraint(equalTo: rightButton.centerXAnchor)
        
        leftAxis?.isActive = true
        
        stackView.addAnchors(top: slidingThingy.bottomAnchor,
                                            leading: self.leadingAnchor,
                                            bottom: self.bottomAnchor,
                                            trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 10),
                                            size: .init(width: (self.frame.width * 2), height: 0))
    }
    /// Animation for switching between two tableViewControllers
//    private var toggle: Bool = true
//    @objc func performAnimation(){
//        let slideRight = {
//            self.stackView.transform = CGAffineTransform(translationX: -self.frame.width, y: 0)
//        }
//        let reset = {
//            self.stackView.transform = .identity
//        }
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut,
//            animations:{
//                self.toggle ? slideRight() : reset()
//            }, completion: nil)
//        toggle = !toggle
//    }
}
