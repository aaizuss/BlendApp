//
//  ForceTouchGestureRecognizer.swift
//  BlendApp
//
//  Created by Amanda Aizuss on 8/20/16.
//  Copyright © 2016 aaizuss. All rights reserved.
//

import UIKit.UIGestureRecognizerSubclass

public class ForceTouchGestureRecognizer: UIGestureRecognizer {
    private var _force: CGFloat = 0.0
    
    public var force: CGFloat { get { return _force } }
    public var threshold: CGFloat = 1.0
    public var forceTouched: Bool = false
    public var maximumForce: CGFloat = 4.0
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        normalizeForceAndFireEvent(state: .began, touches: touches)
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        normalizeForceAndFireEvent(state: .changed, touches: touches)
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        self.state = forceTouched ? .ended : .failed
        forceTouched = false
    }
    
    func normalizeForceAndFireEvent(state: UIGestureRecognizerState, touches: Set<UITouch>) {
        guard let firstTouch = touches.first else {
            return
        }
        
        let normalizedTouch = firstTouch.force / firstTouch.maximumPossibleForce
        
        if forceTouched && normalizedTouch < threshold {
            self.state = .ended
            forceTouched = false
        } else if !forceTouched && normalizedTouch >= threshold {
            self.state = .began
            forceTouched = true
        }
        
        maximumForce = min(firstTouch.maximumPossibleForce, maximumForce)
        _force = firstTouch.force / maximumForce

    }
    
    public override func reset() {
        super.reset()
        
        _force = 0.0
    }
}
