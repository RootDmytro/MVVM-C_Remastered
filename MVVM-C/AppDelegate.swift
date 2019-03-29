//
//  AppDelegate.swift
//  MVVM-C
//
//  Created by Dmytro Yaropovetskyi on 3/29/19.
//  Copyright © 2019 Dmytro Yaropovetskyi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let window = window else {
            return true
        }
        
        appCoordinator = AppCoordinator()
        window.rootViewController = appCoordinator?.viewController
        appCoordinator?.start()
        window.makeKeyAndVisible()
        
        return true
    }

}

