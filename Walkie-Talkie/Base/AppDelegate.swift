//
//  AppDelegate.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 4/3/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import UIKit
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
        
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

