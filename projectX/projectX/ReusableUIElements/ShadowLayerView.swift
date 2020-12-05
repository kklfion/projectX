//
//  ShadowLayerView.swift
//  projectX
//
//  Created by Radomyr Bezghin on 12/3/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

class ShadowLayerView: UIView {
    let shadowLayerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.4
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(shadowLayerView)
        shadowLayerView.addAnchors(top: self.topAnchor,
                          leading: self.leadingAnchor,
                          bottom: self.bottomAnchor,
                          trailing: self.trailingAnchor,
                          padding: .init(top: 0, left: 0, bottom: 0, right: 0),
                          size: .init(width: 0, height: 0))
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}


