//
//  AppDelegate.swift
//  BlendApp
//
//  Created by Amanda Aizuss on 6/16/16.
//  Copyright © 2016 aaizuss. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        let userDefaults = UserDefaults.standard
        
        if userDefaults.bool(forKey: "firstLaunch") {
            print("🔑 AppDelegate says Not First Launch 🔑")
            showBlendScreen()
        } else {
            print("AppDelegate says 💫First Launch!")
            userDefaults.set(true, forKey: "firstLaunch")
            showTutorial()
        }
        userDefaults.synchronize()
        return true
    }
    
    func showBlendScreen() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let blendVC = mainStoryboard.instantiateViewController(withIdentifier: "BlendViewController") as! BlendViewController
        window?.rootViewController = blendVC
        window?.makeKeyAndVisible()
    }
    
    func showTutorial() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tutVC = mainStoryboard.instantiateViewController(withIdentifier: "TutorialViewController") as! TutorialPageViewController
        window?.rootViewController = tutVC
        window?.makeKeyAndVisible()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

