//
//  CollegesListController.swift
//  projectX
//
//  Created by Radomyr Bezghin on 2/10/21.
//  Copyright © 2021 Radomyr Bezghin. All rights reserved.
//

import UIKit

class CollegesListController: UICollectionViewController{
    
    private let collegeCellReuseIdentifier = "cellReuseIdentifier"
    
    private var parentStation: Station
    
    private var colleges = [Station]()
    
    private lazy var dataSource = makeDataSource()
    
    init(parentStation: Station){
        self.parentStation = parentStation
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        collectionView.backgroundColor = .systemGray6
        setupCollection()
        loadData()
    }
    private func setupCollection(){
        collectionView.register(CollegeCell.self, forCellWithReuseIdentifier: collegeCellReuseIdentifier)
        collectionView.collectionViewLayout = createLayout()
        collectionView.dataSource = makeDataSource()
    }
    private func loadData(){
        //1. get stations
        loadSubstations{ result in
            switch result{
            case .success(let colleges):
                self.colleges = colleges
                self.update(with: colleges)
            case .failure(let err):
                print(err)
            }
        }
    }

    
    
}
extension CollegesListController {
    enum Section: CaseIterable {
        case school
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
