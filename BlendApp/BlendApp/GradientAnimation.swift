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
        layer.colors = [UIColor.GradPalette.Sunset.Top, UIColor.GradPalette.Sunset.Top]//[UIColor.GradPalette.BrightPurple.Top, UIColor.GradPalette.BrightPurple.Bottom]
        view.layer.insertSublayer(layer, at: 0)
    }
    
    func animateGradient(layer: CAGradientLayer) {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            layer.removeFromSuperlayer()
        })
        
//        let fromColors = [UIColor.GradPalette.BrightPurple.Top, UIColor.GradPalette.BrightPurple.Bottom]
        //let toColors1 = [UIColor.GradPalette.BrightPurple.Top, UIColor.GradPalette.BrightPurple.Bottom]
        //let toColors1 = [UIColor.GradPalette.Influenza.Top, UIColor.GradPalette.Influenza.Bottom]
        //let toColors1 = [UIColor.GradPalette.Memory.Top, UIColor.GradPalette.Memory.Bottom]
        let fromColors = [UIColor.GradPalette.Sunset.Top, UIColor.GradPalette.Sunset.Top]
        let toColors2 = [UIColor.GradPalette.Sunset.Top, UIColor.GradPalette.Sunset.Bottom]
        //let endColors = [UIColor.GradPalette.DefaultColor.Top ,UIColor.GradPalette.DefaultColor.Bottom]
        
        let animation = CABasicAnimation(keyPath: "colors")
//        layer.colors = toColors1
//        animation.fromValue = fromColors
//        animation.toValue = toColors1
//        animation.duration = 1
//        animation.isRemovedOnCompletion = true
//        animation.fillMode = kCAFillModeForwards
//        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
//        layer.add(animation, forKey: "animateGradient")
        
        layer.colors = toColors2
        animation.fromValue = fromColors
        //animation.fromValue = toColors1
        animation.toValue = toColors2
        animation.duration = 1
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        layer.add(animation, forKey: "animateGradient")
        
//        layer.colors = endColors
//        animation.fromValue = toColors2
//        animation.toValue = endColors
//        animation.duration = 1
//        animation.fillMode = kCAFillModeForwards
//        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
//        layer.add(animation, forKey: "animateGradient")
//        CATransaction.commit()
    }
}
