//
//  SceneDelegate.swift
//  RGH
//
//  Created by Oscar Rodriguez Garrucho on 26/09/2020.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: UIScreen.main.bounds)

        let viewController = HomeRouter().viewController
        let navController = UINavigationController(rootViewController: viewController)

        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
    }
}
