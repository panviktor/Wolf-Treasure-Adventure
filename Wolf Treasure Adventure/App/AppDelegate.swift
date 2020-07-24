//
//  AppDelegate.swift
//  Wolf Treasure Adventure
//
//  Created by Viktor on 24.07.2020.
//  Copyright © 2020 Viktor. All rights reserved.
//


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController =  GameViewController()
        
        window?.makeKeyAndVisible()
        return true
    }
}
