//
//  AppDelegate.swift
//  JodelChallenge
//
//  Created by Michal Ciurus on 21/09/2017.
//  Copyright © 2017 Jodel. All rights reserved.
//

import UIKit
import NotificationBar

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var isAppFirstTimeRun = true

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        
        NetworkManager.sharedInstance.reachability.whenUnreachable = { reachability in
            NotificationBar(over: (self.window?.rootViewController)!, text: "No Internet connectivity", style: .error).show()
            self.displayNotification("No Internet connectivity")
            
        }
        NetworkManager.sharedInstance.reachability.whenReachable = { reachability in
            if self.isAppFirstTimeRun != true{
                NotificationBar(over: (self.window?.rootViewController)!, text: "Back Online", style: .success).show()
                self.displayNotification("You are online")
            }
            
        }
        self.isAppFirstTimeRun = false
        return true
    }
    
    
    
    func displayNotification(_ msg: String!){
        print(msg)
    }
    
}
