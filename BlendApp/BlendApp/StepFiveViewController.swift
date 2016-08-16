//
//  StepFiveViewController.swift
//  BlendApp
//
//  Created by Amanda Aizuss on 6/17/16.
//  Copyright © 2016 aaizuss. All rights reserved.
//

import UIKit

class StepFiveViewController: StepViewController, CAAnimationDelegate {
    
    @IBOutlet weak var shakeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        shakeImageView.animationImages = [
            UIImage(named: "r1")!,
            UIImage(named: "r2")!,
            UIImage(named: "r3")!,
            UIImage(named: "r4")!,
            UIImage(named: "r5")!,
            UIImage(named: "r6")!]
        
        shakeImageView.animationDuration = 6.0
        shakeImageView.startAnimating()
        
        wiggleAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Wiggle the shakeImageView continuously
    func wiggleAnimation() {
        let transform:CATransform3D = CATransform3DMakeRotation(0.08, 0, 0, 1.0);
        let animation:CABasicAnimation = CABasicAnimation(keyPath: "transform");
        animation.toValue = NSValue(caTransform3D: transform);
        animation.autoreverses = true;
        animation.duration = 0.5;
        animation.repeatCount = 10000;
        animation.delegate=self;
        shakeImageView.layer.add(animation, forKey: "wiggleAnimation");
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        wiggleAnimation()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
