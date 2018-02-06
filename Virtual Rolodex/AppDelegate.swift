//
//  AppDelegate.swift
//  Virtual Rolodex
//
//  Created by Jamie Nguyen on 2/6/18.
//  Copyright © 2018 Jamie Nguyen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func checkIfFirstLaunch() {
        if UserDefaults.standard.bool(forKey: "hasLaunchedBefore") {
            print("App has launched before")
        }
        else {
            UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
            UserDefaults.standard.set(0, forKey: "currentIndex")
            UserDefaults.standard.synchronize()
        }
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        checkIfFirstLaunch()
        return true
    }


}

