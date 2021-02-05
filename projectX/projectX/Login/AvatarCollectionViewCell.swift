//
//  AvatarCollectionViewCell.swift
//  projectX
//
//  Created by Adedeji Toki on 2/3/21.
//  Copyright © 2021 Radomyr Bezghin. All rights reserved.
//

import UIKit

class AvatarCollectionViewCell: UICollectionViewCell {

    //var imageName =
    override init(frame: CGRect) {
            super.init(frame: frame)

            addViews()
        }
    
    required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    func addViews(){
        backgroundColor = .white
        addSubview(imageView)
        
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    /*
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setImage(image: UIImage) {
        self.imageView.image = image
    }
     */
}
