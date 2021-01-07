//
//  LoadingFooterView.swift
//  projectX
//
//  Created by Radomyr Bezghin on 1/7/21.
//  Copyright © 2021 Radomyr Bezghin. All rights reserved.
//

import UIKit

class LoadingFooterView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(activityIndicator)
        self.backgroundColor = .red
        activityIndicator.addAnchors(top: self.topAnchor,
                                     leading: self.leadingAnchor,
                                     bottom: self.bottomAnchor,
                                     trailing: self.trailingAnchor)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var isAnimating = false
    var activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        
        return ai
    }()
    func startAnimating(){
        isAnimating = true
        activityIndicator.startAnimating()
    }
    func stopAnimating(){
        isAnimating = false
        activityIndicator.stopAnimating()
    }
}
