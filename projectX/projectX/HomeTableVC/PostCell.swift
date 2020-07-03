//
//  PostCell.swift
//  projectX
//
//  Created by Radomyr Bezghin on 6/29/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//
/*
 Channel its posted on
 who posted it, and when  ------ action button
 Title
 snapshot of Text,  side Picture
 or Main Picture
 or no Picture
 
 vote count, how many comments, share

*/
import UIKit

class PostCell: UITableViewCell {
    let imageIconName = "image_icon"
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    /// Creates a view for channelImage, channelAuthorLabel, optionsButton
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let channelImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image_icon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let channelAuthorLabel: UILabel = {
        let label = UILabel()
        label.text = "r/UCSC\nu/Sammy * 13m"
        label.textColor = .lightGray
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let optionsButton: UIButton = {
        let button = UIButton()
        button.imageView?.image = UIImage(named: "cell_menu_icon")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let middleView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "I Failed CSE12"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let textField: UITextField = {
        let text = UITextField()
        text.text = "I was not even enrolled. How could I even fail this class?! What is happening. AAAAAAAAAA"
        text.textColor = .black
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let bottomStackView: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .green
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        print("calling setup")
        setupContentView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func setupContentView(){
        contentView.addSubview(topView)
        contentView.addSubview(middleView)
        contentView.addSubview(bottomStackView)
        
        topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        topView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        middleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        middleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        middleView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        middleView.bottomAnchor.constraint(equalTo: bottomStackView.topAnchor).isActive = true
        
        bottomStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        bottomStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        bottomStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bottomStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        
        //TOP content
//        topView.addSubview(channelImage)
//        topView.addSubview(channelAuthorLabel)
//        topView.addSubview(optionsButton)
//        channelImage.topAnchor.constraint(equalTo: topHorizontalView.topAnchor).isActive = true
//        channelImage.leadingAnchor.constraint(equalTo: topHorizontalView.leadingAnchor).isActive = true
//        channelImage.bottomAnchor.constraint(equalTo: topHorizontalView.bottomAnchor).isActive = true
//        channelImage.widthAnchor.constraint(equalToConstant: topHorizontalView.frame.height).isActive = true
        //MIDDLE content
//        middleView.addSubview(titleLabel)
//        middleView.addSubview(textField)
        
        //BOTTOM content
        
        
        
        
        
        
//        contentView.addSubview(cellView)
//        cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//        cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//        cellView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//        cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
