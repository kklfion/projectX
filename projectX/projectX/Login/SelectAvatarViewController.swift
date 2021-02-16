//
//  selectAvatarViewController.swift
//  projectX
//
//  Created by Adedeji Toki on 2/3/21.
//  Copyright © 2021 Radomyr Bezghin. All rights reserved.
//

import UIKit

class SelectAvatarViewController: UIViewController {

    weak var delegate: SignUpViewController!
    
    var collectionview: UICollectionView!
    var cellId = "AvatarCollectionViewCell"
    
    let imageNameArray = ["abby","joanne", "jonathan", "kevin", "layla", "ryan"]
    let imageURLArray = ["https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/Avatars%2Fabby.png?alt=media&token=ead9b6d3-7d26-47e3-83b3-678528523ae5",
        "https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/Avatars%2Fjoanne.png?alt=media&token=9575c8ad-3b7a-4bfa-9528-aa8e5c13e391",
        "https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/Avatars%2Fjonathan.png?alt=media&token=d2b83563-b936-4d1c-a6fa-0bfc8bb729fb",
        "https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/Avatars%2Fkevin.png?alt=media&token=b2ef03e1-a145-4462-9b35-5fb7dc054196",
        "https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/Avatars%2Flayla.png?alt=media&token=8659d500-13d5-4ffa-a5d5-69d7535100e7",
        "https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/Avatars%2Fryan.png?alt=media&token=18709310-0c4c-44ed-9163-f60786771bde",]
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Constants.Colors.secondaryBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))

        let titleLabel = UILabel()
        titleLabel.text = "Choose Avatar"
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        titleLabel.textColor = Constants.Colors.mainText
        self.view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleLabel.addAnchors(top: self.view.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        setupCollectionView()
    }
    func setupCollectionView()
    {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width / 4, height: view.frame.width / 4)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        collectionview = UICollectionView(frame: .init(x: 0, y: 40, width: view.frame.width, height: 250), collectionViewLayout: layout)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(AvatarCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionview.showsVerticalScrollIndicator = false
        collectionview.backgroundColor = Constants.Colors.secondaryBackground
        self.view.addSubview(collectionview)
    }
    @objc func addTapped()
    {
        
    }

}

extension SelectAvatarViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AvatarCollectionViewCell
        cell.imageView.image = UIImage(named: imageNameArray[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.setNewImage(imageName: imageNameArray[indexPath.row], imageURL: imageURLArray[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
    
}
