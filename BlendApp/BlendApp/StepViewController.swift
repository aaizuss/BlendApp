//
//  StepViewController.swift
//  BlendApp
//
//  Created by Amanda Aizuss on 6/17/16.
//  Copyright © 2016 aaizuss. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

/// Thanks to https://github.com/kschaller/ios-video-background-swift
class StepViewController: UIViewController {
    
    var player: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepareTutVideo(title: String) {
        let videoURL: URL = Bundle.main.url(forResource: title, withExtension: "mov")!
        player = AVPlayer(url: videoURL)
        player?.actionAtItemEnd = .none
        player?.isMuted = true
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspect
        playerLayer.zPosition = -1
        
        playerLayer.frame = view.frame
        view.layer.addSublayer(playerLayer)
        player?.play()
        
        // loop video
        NotificationCenter.default.addObserver(self, selector: #selector(self.loopVideo), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    func loopVideo() {
        player?.seek(to: kCMTimeZero)
        player?.play()
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
