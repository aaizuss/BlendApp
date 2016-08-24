//
//  TransitionInteractor.swift
//  BlendApp
//
//  Created by Amanda Aizuss on 8/24/16.
//  Copyright © 2016 aaizuss. All rights reserved.
//

import Foundation
import UIKit

class TransitionInteractor: UIPercentDrivenInteractiveTransition {
    var hasStarted = false
    var shouldFinish = false
    private var exitPanGesture: UIPanGestureRecognizer!
    
    var modalViewController: UIViewController! {
        didSet {
            self.exitPanGesture = UIPanGestureRecognizer()
            self.exitPanGesture.addTarget(self, action:#selector(handleExitGesture))
            self.modalViewController.view.addGestureRecognizer(self.exitPanGesture)
        }
    }
    
    func handleExitGesture(_ sender: UIPanGestureRecognizer) {
        let percentThreshold: CGFloat = 0.3
        // convert y-position to downward pull progress (percentage)
        let translation = sender.translation(in: sender.view)
        let verticalMovement = translation.y / sender.view!.bounds.height
        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
        let downwardMovementPercent = fminf(downwardMovement, 1.0)
        let progress = CGFloat(downwardMovementPercent)
        
        switch sender.state {
        case .began:
            hasStarted = true
            modalViewController.performSegue(withIdentifier: "BackToBlend", sender: self)
        case .changed:
            shouldFinish = progress > percentThreshold
            update(progress)
        case .cancelled:
            hasStarted = false
            cancel()
        case .ended:
            hasStarted = false
            shouldFinish
                ? finish()
                : cancel()
        default:
            break
        }
    }
}
