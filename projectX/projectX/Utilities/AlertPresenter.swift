//
//  AlertPresenter.swift
//  projectX
//
//  Created by Radomyr Bezghin on 11/3/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

enum AlertResponseChoice{
    case accepted
    case rejected
}
///alert presenter that has two different options : accepted or rejected.
///depending on answer different actions can be created
struct ConfirmationPresenter {
    
    /// The question we want the user to confirm
    let question: String
    
    /// The title of the button to accept the confirmation
    let acceptTitle: String
    
    /// The title of the button to reject the confirmation
    let rejectTitle: String
    
    /// A closure to be run when the user taps one of the
    /// alert's buttons. Outcome is an enum with two cases:
    /// .accepted and .rejected.
    let handler: (AlertResponseChoice) -> Void

    func present(in viewController: UIViewController) {
        let alert = UIAlertController(
            title: nil,
            message: question,
            preferredStyle: .alert
        )

        let rejectAction = UIAlertAction(title: rejectTitle, style: .cancel) { _ in
            self.handler(.rejected)
        }

        let acceptAction = UIAlertAction(title: acceptTitle, style: .default) { _ in
            self.handler(.accepted)
        }

        alert.addAction(rejectAction)
        alert.addAction(acceptAction)

        viewController.present(alert, animated: true)
    }
}

///simple alert that present confirmation that some event has occured or something is missing
///when action is tapped, handler closure is called and confirmation be handled (alert dissmissed)
struct AlertPresenter {
    
    /// The question we want the user to confirm
    let message: String
    
    /// The title of the button to accept the confirmation
    let OK: String = "OK"
    
    /// dissmiss me?
    let handler: () -> Void
    
    func present(in viewController: UIViewController) {
        let alert = UIAlertController(
            title: nil,
            message: message,
            preferredStyle: .alert
        )
        let acceptAction = UIAlertAction(title: OK, style: .default) { _ in
            self.handler()
        }
        alert.addAction(acceptAction)
        viewController.present(alert, animated: true)
    }
}
