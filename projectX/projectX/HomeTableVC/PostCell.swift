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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView(){
        backgroundColor = .red
    }
}
