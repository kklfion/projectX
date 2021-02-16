//
//  SideBarView.swift
//  projectX
//
//  Created by Radomyr Bezghin on 9/21/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit
class SideBarView: UIView {
    static let menuCellID = "menuTableViewCell"
    static let stationsCellID = "stationsTableViewCell"
    
    let menuItems = ["Match","Friends","Library","Night Mode","Settings"]
    let imageNames = ["flame", "person.2", "book", "moon.stars", "gear"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    let stationsTableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = Constants.Colors.secondaryBackground
        tv.separatorStyle = .none
        return tv
    }()
    let spacingView: UIView  = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.alpha = 0.5
        return view
    }()
    let menuTableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = Constants.Colors.secondaryBackground
        tv.separatorStyle = .none
        tv.isScrollEnabled = false
        return tv
    }()
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()

    private func setupViews(){
        self.backgroundColor = Constants.Colors.secondaryBackground
        self.addSubview(cancelButton)
        self.addSubview(stationsTableView)
        self.addSubview(spacingView)
        self.addSubview(menuTableView)

        cancelButton.addAnchors(top: self.safeAreaLayoutGuide.topAnchor,
                                leading: self.safeAreaLayoutGuide.leadingAnchor,
                                bottom: nil,
                                trailing: nil,
                                padding: .init(top: 10, left: 10, bottom: 0, right: 0))
        stationsTableView.addAnchors(top: cancelButton.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 0, left: 10, bottom: 0, right: 10),size: .init(width: 0, height: self.frame.height * 0.6))
        spacingView.addAnchors(top: stationsTableView.bottomAnchor,
                                leading: self.leadingAnchor,
                                bottom: nil,
                                trailing: self.trailingAnchor,
                                padding: .init(top: 5, left: 10, bottom: 0, right: 10),
                                size: .init(width: 0, height: 1))
        menuTableView.addAnchors(top: spacingView.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: self.bottomAnchor,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 5, left: 10, bottom: 10, right: 10))
        
    }
}
