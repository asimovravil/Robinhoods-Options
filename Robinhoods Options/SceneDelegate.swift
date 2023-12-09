//
//  SceneDelegate.swift
//  Robinhoods Options
//
//  Created by Ravil on 07.12.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.overrideUserInterfaceStyle = .light
        window.rootViewController =
        UINavigationController(rootViewController: QuizGameViewController())
        window.makeKeyAndVisible()
        self.window = window
    }
}

