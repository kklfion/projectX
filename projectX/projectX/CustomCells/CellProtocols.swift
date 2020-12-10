//
//  PostCellDidTapProtocol.swift
//  projectX
//
//  Created by Radomyr Bezghin on 10/21/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//
import Foundation
///protocol that enables cell buttons
protocol PostCellDidTapDelegate: class{
    /// returns index of a cell that was tapped
    func didTapStationButton(_ indexPath: IndexPath)
    /// returns index of a cell that was tapped
    func didTapLikeButton(_ indexPath: IndexPath)
    /// returns index of a cell that was tapped
    func didTapDislikeButton(_ indexPath: IndexPath)
    /// returns index of a cell that was tapped
    func didTapCommentsButton(_ indexPath: IndexPath)
    /// returns index of a cell that was tapped
    func didTapAuthorLabel(_ indexPath: IndexPath)
    /// returns index of a cell that was tapped
}
protocol PostCollectionViewCellDidTapDelegate: class{
    /// returns index of a cell that was tapped
    func didTapStationButton(_ indexPath: IndexPath)
    /// returns index of a cell that was tapped
    func didTapLikeButton(_ cell: PostCollectionViewCell)
    /// returns index of a cell that was tapped
    func didTapDislikeButton(_ indexPath: IndexPath)
    /// returns index of a cell that was tapped
    func didTapCommentsButton(_ indexPath: IndexPath)
    /// returns index of a cell that was tapped
    func didTapAuthorLabel(_ indexPath: IndexPath)
    /// returns index of a cell that was tapped
}
