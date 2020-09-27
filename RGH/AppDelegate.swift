//
//  AppDelegate.swift
//  RGH
//
//  Created by Oscar Rodriguez Garrucho on 26/09/2020.
//  Copyright © 2020 Little Monster. All rights reserved.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13.0, *) { } else {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let homeView = HomeRouter().viewController
            let navController = UINavigationController(rootViewController: homeView)
            self.window!.rootViewController = navController
            self.window!.makeKeyAndVisible()
        }
        return true
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

