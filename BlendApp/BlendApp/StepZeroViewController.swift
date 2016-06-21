//
//  StepZeroViewController.swift
//  BlendApp
//
//  Created by Amanda Aizuss on 6/17/16.
//  Copyright © 2016 aaizuss. All rights reserved.
//

import UIKit

class StepZeroViewController: StepViewController {

    @IBOutlet weak var wallpaperImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // animate through the sample images
        wallpaperImageView.animationImages = [
            UIImage(named: "ex1")!,
            UIImage(named: "ex2")!,
            UIImage(named: "ex3")!,
            UIImage(named: "ex4")!,
            UIImage(named: "ex5")!,
            UIImage(named: "ex6")!,
            UIImage(named: "ex7")!,
            UIImage(named: "ex8")!,
            UIImage(named: "ex9")!]
        
        wallpaperImageView.animationDuration = 8.0
        wallpaperImageView.startAnimating()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
