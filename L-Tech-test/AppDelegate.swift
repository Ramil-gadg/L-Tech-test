//
//  AppDelegate.swift
//  L-Tech-test
//
//  Created by Рамил Гаджиев on 18.10.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let rootVC = AuthorizationViewController()
        let navC = UINavigationController(rootViewController: rootVC)
        window?.rootViewController = navC
        window?.makeKeyAndVisible()
        
        return true
    }
}

