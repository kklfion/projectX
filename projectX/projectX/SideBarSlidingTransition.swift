//
//  SideBarSlidingTransition.swift
//  projectX
//
//  Created by Radomyr Bezghin on 9/19/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit
/// for custom transitioning of the sidebar
/// Appears left to right and takes only 50% of the width
class SideBarSlidingTransition: NSObject, UIViewControllerAnimatedTransitioning{
    var isPresenting = false
    let dimmingView = UIView()
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
              let fromViewController =  transitionContext.viewController(forKey: .from) else {
            return
        }
        let containerView = transitionContext.containerView
        let finalWidth = containerView.frame.width * 0.5
        let finalHeight = containerView.frame.height
        
        if isPresenting{
            // dimming view
            dimmingView.backgroundColor = .black
            dimmingView.alpha = 0.0
            dimmingView.frame = containerView.frame
            containerView.addSubview(dimmingView)
            // add sidebar to the container
            containerView.addSubview(toViewController.view)
            //init its fram offscreen
            toViewController.view.frame = CGRect(x: -finalWidth, y: 0, width: finalWidth, height: finalHeight)
        }
        let transform = {
            self.dimmingView.alpha = 0.4
            toViewController.view.transform = CGAffineTransform(translationX: finalWidth, y: 0)
        }
        let reset = {
            self.dimmingView.alpha = 0.0
            fromViewController.view.transform = .identity
        }
        let duration = transitionDuration(using: transitionContext)
        let isCanceled = transitionContext.transitionWasCancelled
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations:
                       {
            self.isPresenting ? transform() : reset()
        }) { _ in
            transitionContext.completeTransition(!isCanceled)
        }
    }
}
