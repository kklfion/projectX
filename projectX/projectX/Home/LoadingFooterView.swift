//
//  LoadingFooterView.swift
//  projectX
//
//  Created by Radomyr Bezghin on 1/7/21.
//  Copyright © 2021 Radomyr Bezghin. All rights reserved.
//

import UIKit
///This view is used to show loading of additional data when users scrolls the collectionView. It works together with pagination.
class LoadingFooterView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(activityIndicator)
        activityIndicator.addAnchors(top: self.topAnchor,
                                     leading: self.leadingAnchor,
                                     bottom: self.bottomAnchor,
                                     trailing: self.trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isAnimating = false
    
    let activityIndicator = UIActivityIndicatorView()
    
    func startAnimating(){
        isAnimating = true
        activityIndicator.startAnimating()
    }
    
    func stopAnimating(){
        isAnimating = false
        activityIndicator.stopAnimating()
    }
}
