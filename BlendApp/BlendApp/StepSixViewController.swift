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

        let launchedBefore = UserDefaults.standard.bool(forKey: "firstLaunch")
        if launchedBefore {
            self.dismiss(animated: true, completion: nil)
        } else {
            UserDefaults.standard.set(true, forKey: "firstLaunch")
            let snapshot: UIView = self.view.window!.snapshotView(afterScreenUpdates: true)!
            blendVC.view.addSubview(snapshot)
            self.view.window?.rootViewController = blendVC
            UIView.animate(withDuration: 0.5, animations: {() in
                snapshot.layer.opacity = 0
                }, completion: {(completion) in
                    snapshot.removeFromSuperview()
            })
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
