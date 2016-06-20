//
//  ColorPickerView.swift
//  BlendApp
//
//  Created by Amanda Aizuss on 6/16/16.
//  Copyright © 2016 aaizuss. All rights reserved.
//

import UIKit

class ColorPickerView: UIView, UIGestureRecognizerDelegate {

    // MARK: Properties
    var viewCenter = CGPoint()
    var indicator = UIView() // follows user's finger in the circle
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Wheel
        createCircle()
        
        // Indicator
        indicator = drawIndicatorView()
        indicator.center = CGPoint(x: frame.width/2, y: frame.height/2)
        self.addSubview(indicator)
    }
    
    // make sure the view is a circle even when using autolayout h and w constraints
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width/2
    }
    
    func createCircle() {
        viewCenter = CGPoint(x: frame.width/2, y: frame.height/2)
        backgroundColor = UIColor.clear()
        layer.cornerRadius = frame.width/2 // makes the view a circle
        layer.borderWidth = 3
        layer.borderColor = UIColor.white().cgColor
    }
    
    /// Draw the indicator in the circle
    func drawIndicatorView() -> UIView {
        let indicator = UIView(frame: CGRect(x: 0, y: 0, width: 23, height: 23))
        indicator.center = CGPoint(x: viewCenter.x, y: viewCenter.y)
        indicator.layer.cornerRadius = indicator.frame.width/2
        indicator.backgroundColor = UIColor.white()
        indicator.alpha = 0.5
        indicator.isUserInteractionEnabled = true
        return indicator
    }
    
    // MARK: Color Determination
    
    /// Returns the hue and saturation from the touch point in the circle view
    /// - Math Attributions: https://github.com/johankasperi/SwiftHSVColorPicker
    /// - Parameters:
    ///     - position: the touch point (x,y) in the circle
    func hueSaturationAtPoint(_ position: CGPoint) -> (hue: CGFloat, saturation: CGFloat) {
        let c = self.frame.width / 2
        let dx = CGFloat(position.x - c) / c
        let dy = CGFloat(position.y - c) / c
        let d = sqrt(CGFloat(dx * dx + dy * dy))
        
        let sat: CGFloat = d
        
        var hue: CGFloat
        if (d == 0) {
            hue = 0
        } else {
            hue = acos(dx/d) / CGFloat(M_PI) / 2.0
            if (dy < 0) {
                hue = 1.0 - hue
            }
        }
        return (hue, sat)
    }
    
    /// Get a point (x,y) in the wheel for a given hue and saturation
    func pointAtHueSaturation(hue: CGFloat, saturation: CGFloat) -> CGPoint {
        let dimension: CGFloat = min(self.frame.width, self.frame.height)
        let radius: CGFloat = saturation * dimension / 2
        let x = dimension / 2 + radius * cos(hue * CGFloat(M_PI) * 2)
        let y = dimension / 2 + radius * sin(hue * CGFloat(M_PI) * 2)
        return CGPoint(x: x, y: y)
    }
    
    // MARK: Circle Utils
    
    /// Return true if point is in circle given the circle radius and center
    func inCircle(point: CGPoint, center: CGPoint, radius: CGFloat) -> Bool {
        let dx = point.x - center.x
        let dy = point.y - center.y
        return (dx*dx + dy*dy) < (radius*radius)
    }
    
    /// If the touch coordinate is outside the radius of the circle, call this function
    /// transform the point to the edge of the wheel with polar coordinates
    func getNewCoord(tpoint: CGPoint, center: CGPoint, radius: CGFloat) -> CGPoint {
        let dx = tpoint.x - center.x
        let dy = tpoint.y - center.y
        
        var output: CGPoint = tpoint
        let theta: CGFloat = atan2(dy, dx)
        output.x = radius * cos(theta) + center.x
        output.y = radius * sin(theta) + center.y
        
        return output
    }
    
}
