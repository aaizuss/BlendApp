//
//  UIViewAnimations.swift
//  BlendApp
//
//  Created by Amanda Aizuss on 8/17/16.
//  Copyright © 2016 aaizuss. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func fade(toAlpha alpha: CGFloat, withDuration duration: TimeInterval) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: {
            self.alpha = alpha
            }, completion: nil)
    }
}
