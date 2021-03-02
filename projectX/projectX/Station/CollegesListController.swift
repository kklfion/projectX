//
//  CollegesListController.swift
//  projectX
//
//  Created by Radomyr Bezghin on 2/10/21.
//  Copyright © 2021 Radomyr Bezghin. All rights reserved.
//

import UIKit

class CollegesListController: UICollectionViewController{
    
    enum Section: CaseIterable {
        case school
    }
    
    private let collegeCellReuseIdentifier = "cellReuseIdentifier"
    
    private var parentStation: Station
    
    private var colleges = [Station]()
    
    private var imagesForColleges = [Station: UIImage]()
    
    private lazy var dataSource = makeDataSource()
    
    ///delegated used to send scrolling data to the parent view (station)
    var didScrollFeedDelegate: DidScrollFeedDelegate?
    
    init(parentStation: Station){
        self.parentStation = parentStation
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        collectionView.backgroundColor = Constants.Colors.mainBackground
        setupCollection()
        DispatchQueue.global(qos: .userInitiated).async {
            self.loadData()
        }
    }
    private func setupCollection(){
        collectionView.register(CollegeCell.self, forCellWithReuseIdentifier: collegeCellReuseIdentifier)
        collectionView.collectionViewLayout = createLayout()
        collectionView.dataSource = makeDataSource()
    }
    private func loadData(){
        let group = DispatchGroup()
        //1. get stations
        group.enter()
        loadSubstations{ result in
            switch result{
            case .success(let colleges):
                self.colleges = colleges
                //self.update(with: colleges)
            case .failure(let err):
                print(err)
            }
            group.leave()
        }
        //2. get images
        group.wait()
        group.enter()
        loadImagesForstations { (result) in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let imagesDict):
                self.imagesForColleges = imagesDict
            }
            group.leave()
        }
        group.wait()
        //3. update 
        DispatchQueue.main.async {
            self.update(with: self.colleges)
        }
        
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let collegeVC = SubstationViewController(station: colleges[indexPath.item])
        self.navigationController?.pushViewController(collegeVC, animated: true)
    }

}
extension CollegesListController{
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScrollFeedDelegate?.didScrollFeed(scrollView)
    }
}
extension CollegesListController {
    func loadSubstations(completion: @escaping (Result<[Station], Error>) -> Void) {
        let query = NetworkManager.shared.db.stations.whereField(FirestoreFields.parentStationID.rawValue, isEqualTo: self.parentStation.id ?? "")
        NetworkManager.shared.getDocumentsForQuery(query: query) { (documents: [Station]?, error) in
            if let docs = documents {
                self.colleges.append(contentsOf: docs)
                completion(.success(docs))
            }else if let err = error{
                completion(.failure(err))
            }
        }
    }
    func loadImagesForstations(completion: @escaping (Result<[Station: UIImage], Error>) -> Void) {
        let group = DispatchGroup()
        var imagesDict = [Station: UIImage]()
        for college in colleges{
            group.enter()
            NetworkManager.shared.getAsynchImage(withURL: college.frontImageURL) { (image, err) in
                if let image = image {
                    imagesDict[college]=image
                } else {
                    imagesDict[college]=UIImage(named: "sslug")
                }
                group.leave()
            }
        }
        group.notify(queue: DispatchQueue.global()){
            completion(.success(imagesDict))
        }
    }
}
extension CollegesListController {
    func update(with stations: [Station], animate: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Station>()
        snapshot.appendSections([Section.school])
        snapshot.appendItems(stations, toSection: .school)
        dataSource.apply(snapshot, animatingDifferences: animate)
    }
}
private extension CollegesListController {
    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, Station> {
        let reuseIdentifier = collegeCellReuseIdentifier
        return UICollectionViewDiffableDataSource<Section, Station>(
            collectionView: collectionView,
            cellProvider: {  collectionView, indexPath, station in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: reuseIdentifier,
                    for: indexPath
                ) as! CollegeCell

                cell.schoolNameLabel.text = station.stationName
                cell.schoolFollowersLabel.text = "\(station.followers) followers"
                cell.schoolImageView.image = self.imagesForColleges[station]
                return cell
            }
        )
    }
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(90))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)
    
        return UICollectionViewCompositionalLayout(section: section)
    }
}
