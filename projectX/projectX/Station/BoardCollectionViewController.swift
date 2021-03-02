//
//  BoardCollectionViewController.swift
//  projectX
//
//  Created by Gurpreet Dhillon on 2/23/21.
//  Copyright © 2021 Radomyr Bezghin. All rights reserved.
//

import UIKit

class BoardCollectionViewController: UICollectionViewController {
    
    private let boardCellReuseIdentifier = "cellReuseIdentifier"
    
    private var station: Station
    
    private var mission = [Mission]()
    
    private lazy var dataSource = makeDataSource()
    
    init(station: Station){
        self.station = station
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        collectionView.backgroundColor = Constants.Colors.mainBackground
        setupCollection()
        loadData()
    }
    private func setupCollection(){
        collectionView.register(BoardCell.self, forCellWithReuseIdentifier: boardCellReuseIdentifier)
        collectionView.collectionViewLayout = createLayout()
        collectionView.dataSource = makeDataSource()
    }
    private func loadData(){
        loadMissions{ result in
            switch result{
            case .success(let mission):
                self.mission = mission
                self.update(with: mission)
            case .failure(let err):
                print(err)
            }
        }
    }

    
    
}
extension BoardCollectionViewController {
    enum Section: CaseIterable {
        case mission
    }
}
extension BoardCollectionViewController{
    func loadMissions(completion: @escaping (Result<[Mission], Error>) -> Void) {
        let query = NetworkManager.shared.db.stations.whereField(FirestoreFields.missionID.rawValue, isEqualTo: self.station.id ?? "")
        NetworkManager.shared.getDocumentsForQuery(query: query) { (documents: [Mission]?, error) in
            if let docs = documents {
                self.mission.append(contentsOf: docs)
                completion(.success(docs))
            }else if let err = error{
                completion(.failure(err))
            }
        }
    }
}
extension BoardCollectionViewController {
    func update(with missions: [Mission], animate: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section,Mission>()
        snapshot.appendSections([Section.mission])
        snapshot.appendItems(missions, toSection: .mission)
        dataSource.apply(snapshot, animatingDifferences: animate)
    }
}
private extension BoardCollectionViewController {
    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, Mission> {
        let reuseIdentifier = boardCellReuseIdentifier
        return UICollectionViewDiffableDataSource<Section, Mission>(
            collectionView: collectionView,
            cellProvider: {  collectionView, indexPath, station in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: reuseIdentifier,
                    for: indexPath
                ) as! BoardCell
                
                cell.locationLabel.text = station.stationName
                return cell
            }
        )
    }

    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let spacing = CGFloat(10)
        group.interItemSpacing = .fixed(spacing)

        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)
    
        return UICollectionViewCompositionalLayout(section: section)
    }
}
