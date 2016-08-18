//
//  GradientAnimation.swift
//  BlendApp
//
//  Created by Amanda Aizuss on 8/18/16.
//  Copyright © 2016 aaizuss. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setupAnimationLayer(layer: CAGradientLayer) {
        layer.frame = view.bounds
        layer.colors = [UIColor.GradPalette.Sunset.Top, UIColor.GradPalette.Sunset.Top]
        view.layer.insertSublayer(layer, at: 0)
    }
    
    func animateGradient(layer: CAGradientLayer) {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            layer.removeFromSuperlayer()
        })
        
        let fromColors = [UIColor.GradPalette.Sunset.Top, UIColor.GradPalette.Sunset.Top]
        let toColors = [UIColor.GradPalette.Start.Top, UIColor.GradPalette.Start.Bottom]
        
        let animation = CABasicAnimation(keyPath: "colors")
        
        layer.colors = toColors
        animation.fromValue = fromColors
        animation.toValue = toColors
        animation.duration = 0.6
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        layer.add(animation, forKey: "animateGradient")
        
        CATransaction.commit()
    }
}
