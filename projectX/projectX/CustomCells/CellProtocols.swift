//
//  PostCellDidTapProtocol.swift
//  projectX
//
//  Created by Radomyr Bezghin on 10/21/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//
import Foundation
protocol PostCellDidTapDelegate: class{
    /// returns index of a cell that was tapped
    func didTapStationButton(_ indexPath: IndexPath)
    func didTapLikeButton(_ indexPath: IndexPath)
    func didTapDislikeButton(_ indexPath: IndexPath)
    func didTapCommentsButton(_ indexPath: IndexPath)
    func didTapAuthorLabel(_ indexPath: IndexPath)
}
