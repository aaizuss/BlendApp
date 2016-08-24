//
//  DismissAnimator.swift
//  BlendApp
//
//  Created by Amanda Aizuss on 8/24/16.
//  Copyright © 2016 aaizuss. All rights reserved.
//

import Foundation
import UIKit

class DismissAnimator: NSObject {
    
}

extension DismissAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        else {
            return
        }
        
        let containerView = transitionContext.containerView
        
        // insert parent view controller behind the modal
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        let screenBounds = UIScreen.main.bounds
        let bottomLeftCorner = CGPoint(x: 0, y: screenBounds.height)
        let finalFrame = CGRect(origin: bottomLeftCorner, size: screenBounds.size)
        let duration  = transitionDuration(using: transitionContext)
        // moves the from view down by one screen length
        UIView.animate(withDuration: duration, animations: {
            fromVC.view.frame = finalFrame
            }, completion: {_ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })

    }
}
