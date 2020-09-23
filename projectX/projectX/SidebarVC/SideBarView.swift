//
//  SideBarView.swift
//  projectX
//
//  Created by Radomyr Bezghin on 9/21/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit
class SideBarView: UIView {
    
    let stations = [
        "Travel", "Art", "Drama", "Gaming", "Meme", "Makeup", "Politics","Music",
        "Sports","Food", "Abroad", "Writing","Financial", "Pets", "Job", "Astrology", "Horror",
        "Anime", "LGBTQ+", "Film", "Relationship", "Photography", "International", "Development",
        "Relationship", "Photography", "International", "Development"
    ]
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
    let stationsStackView: UIStackView = {
        let sv = UIStackView()
        sv.distribution = .fillEqually
        sv.axis = .horizontal
        //sv.backgroundColor = .green
        return sv
    }()
    let leftStackView: UIStackView = {
        let sv = UIStackView()
        sv.distribution = .fillEqually
        sv.axis = .vertical
        sv.alignment = .center
        //sv.backgroundColor = .green
        return sv
    }()
    let rightStackView: UIStackView = {
        let sv = UIStackView()
        sv.distribution = .fillEqually
        sv.alignment = .center
        sv.axis = .vertical
        //sv.backgroundColor = .red
        return sv
    }()
    let bottomStackView: UIStackView = {
        let sv = UIStackView()
        sv.backgroundColor = .blue
        return sv
    }()
    let spacingView: UIView  = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.alpha = 0.5
        return view
    }()
    static let CellID = "menuTableViewCell"
    let menuTableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.isScrollEnabled = false
        return tv
    }()
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        return button
    }()

    private func setupViews(){
        createStationButtons()
        stationsStackView.addArrangedSubview(leftStackView)
        stationsStackView.addArrangedSubview(rightStackView)
        
        self.backgroundColor = .white
        self.addSubview(cancelButton)
        self.addSubview(stationsStackView)
        self.addSubview(spacingView)
        self.addSubview(menuTableView)

        
        cancelButton.addAnchors(top: self.safeAreaLayoutGuide.topAnchor,
                                leading: self.safeAreaLayoutGuide.leadingAnchor,
                                bottom: nil,
                                trailing: nil,
                                padding: .init(top: 10, left: 10, bottom: 0, right: 0))
        stationsStackView.addAnchors(top: cancelButton.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 0, left: 10, bottom: 0, right: 10))
        spacingView.addAnchors(top: stationsStackView.bottomAnchor,
                                leading: self.leadingAnchor,
                                bottom: nil,
                                trailing: self.trailingAnchor,
                                padding: .init(top: 5, left: 10, bottom: 0, right: 10),
                                size: .init(width: 0, height: 1))
        menuTableView.addAnchors(top: spacingView.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: self.bottomAnchor,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 5, left: 10, bottom: 10, right: 0))
        
    }
    private func createStationButtons(){
        var buttons = [UIButton]()
        for i in 0..<stations.count{
            let button = UIButton()
            button.setTitle(stations[i], for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.tag = i
            buttons.append(button)
        }
        var toogle = true
        for button in buttons{
            toogle ? leftStackView.addArrangedSubview(button) : rightStackView.addArrangedSubview(button)
            toogle.toggle()
        }
        
    }
}
