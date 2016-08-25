//
//  StepSixViewController.swift
//  BlendApp
//
//  Created by Amanda Aizuss on 6/24/16.
//  Copyright © 2016 aaizuss. All rights reserved.
//

import UIKit

class StepSixViewController: StepViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapStartBlend(_ sender: UIButton) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let blendVC = mainStoryboard.instantiateInitialViewController() as! BlendViewController
        self.view.window?.rootViewController = blendVC
    }
    
    func simpleTransition(to view: UIView, rootViewController: UIViewController) {
        UIView.transition(from: self.view, to: view, duration: 0.5, options: .transitionCrossDissolve) { (completed) -> Void in
            if (completed) {
                self.view.window?.rootViewController = rootViewController
            }
        }
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
