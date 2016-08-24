//
//  TransitionManager.swift
//  BlendApp
//
//  Created by Amanda Aizuss on 8/16/16.
//  Copyright © 2016 aaizuss. All rights reserved.
//

import UIKit

// idea: don't respond to transitions when in edit mode?

class TransitionManager: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    private var presenting = true
    private var interactive = false
    private var enterPanGesture: UIScreenEdgePanGestureRecognizer!
    private var exitPanGesture: UIPanGestureRecognizer!
    
    var sourceViewController: UIViewController! {
        didSet {
            self.enterPanGesture = UIScreenEdgePanGestureRecognizer()
            self.enterPanGesture.addTarget(self, action: #selector(handleOnstagePan))
            self.enterPanGesture.edges = UIRectEdge.right
            self.sourceViewController.view.addGestureRecognizer(self.enterPanGesture)
        }
    }
    
    var destViewController: UIViewController! {
        didSet {
            self.exitPanGesture = UIPanGestureRecognizer()
            self.exitPanGesture.addTarget(self, action:#selector(handleOffstagePan))
            self.destViewController.view.addGestureRecognizer(self.exitPanGesture)
        }
    }
    
    func handleOnstagePan(pan: UIScreenEdgePanGestureRecognizer){
        let translation = pan.translation(in: pan.view!)
        let d = translation.x / (pan.view!.bounds.width) * -0.5

        switch(pan.state) {
        case .began:
            self.interactive = true
            self.sourceViewController.performSegue(withIdentifier: "ShowSavedBlends", sender: self)
            break
        case .changed:
            update(d)
            break
        default:
            self.interactive = false
            if d > 0.1 {
                finish()
            }
            else {
                cancel()
            }
        }
    }
    
    func handleOffstagePan(pan: UIPanGestureRecognizer) {
        let translation = pan.translation(in: pan.view!)
        let d = translation.x / pan.view!.bounds.width * 0.5

        switch (pan.state) {
        case .began:
            interactive = true
            destViewController.performSegue(withIdentifier: "BackToBlendFromNav", sender: self)
            break
        case .changed:
            update(d)
            break
        default:
            self.interactive = false
            if d > 0.1 {
                finish()
            }
            else {
                cancel()
            }
        }
    }
    
    
    // MARK: UIViewControllerAnimatedTransitioning Protocol Methods
    
    // animate a change from one viewcontroller to another
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let (container, fromView, toView) = getViewReferences(using: transitionContext)
        let duration = self.transitionDuration(using: transitionContext)
        performSlideAnimation(fromView: fromView, toView: toView, container: container, with: transitionContext, duration: duration)
    }
    
    func getViewReferences(using transitionContext: UIViewControllerContextTransitioning) -> (UIView, UIView, UIView) {
        let container = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)!
        let toView = transitionContext.view(forKey: .to)!
        
        return (container, fromView, toView)
    }
    
    func transformsForSlideAnimation(containerView: UIView) -> (CGAffineTransform, CGAffineTransform) {
        let offScreenRight = CGAffineTransform(translationX: containerView.frame.width, y: 0)
        let offScreenLeft = CGAffineTransform(translationX: -containerView.frame.width, y: 0)
        return (offScreenLeft, offScreenRight)
    }
    
    func performSlideAnimation(fromView: UIView, toView: UIView, container: UIView, with transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) {
        let (offScreenLeft, offScreenRight) = transformsForSlideAnimation(containerView: container)
        
        if self.presenting {
            toView.transform = offScreenRight
        } else {
            toView.transform = offScreenLeft
        }
        
        container.addSubview(toView)
        container.addSubview(fromView)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
            if self.presenting {
                fromView.transform = offScreenLeft
            } else {
                fromView.transform = offScreenRight
            }
            toView.transform = CGAffineTransform.identity
            }, completion: { finished in
                if transitionContext.transitionWasCancelled {
                    transitionContext.completeTransition(false)
                    print("transition cancelled")
                } else {
                    transitionContext.completeTransition(true)
                }
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    // MARK: UIViewControllerInteractiveTransitioning Delegate protocol methods
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactive ? self : nil
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning)
        -> UIViewControllerInteractiveTransitioning? {
        return self.interactive ? self : nil
    }
    
    // MARK: UIViewControllerTransitioningDelegate protocol methods
    
    // return the animator when presenting a view controller
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    // return the animator used when dismissing from a viewcontroller
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
}
