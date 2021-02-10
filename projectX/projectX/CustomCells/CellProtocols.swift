//
//  PostCellDidTapProtocol.swift
//  projectX
//
//  Created by Radomyr Bezghin on 10/21/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//
import Foundation
protocol PostCollectionViewCellDidTapDelegate: class{
    /// returns index of a cell that was tapped
    func didTapStationButton(_ indexPath: IndexPath)
    /// returns index of a cell that was tapped
    func didTapLikeButton(_ indexPath: IndexPath, _ cell: PostCollectionViewCell)
    /// returns index of a cell that was tapped
    func didTapCommentsButton(_ indexPath: IndexPath)
    /// returns index of a cell that was tapped
    func didTapAuthorLabel(_ indexPath: IndexPath)
    /// returns index of a cell that was tapped
}
protocol LikeableCellProtocol {
    ///when changing isLiked should change UI of the view
    var isLiked: Bool { get set }
    func changeCellToLiked()
    func changeCellToDisliked()
}
