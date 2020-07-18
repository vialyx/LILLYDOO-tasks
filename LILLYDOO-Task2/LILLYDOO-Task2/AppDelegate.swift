//
//  AppDelegate.swift
//  LILLYDOO-Task2
//
//  Created by Maxim Vialyx on 7/18/20.
//  Copyright © 2020 Maxim Vialyx. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = NavigationController(rootViewController: ViewController())
        window?.makeKeyAndVisible()
        return true
    }

}

