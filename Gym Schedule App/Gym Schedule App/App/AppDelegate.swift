//
//  AppDelegate.swift
//  Gym Schedule App
//
//  Created by ana namgaladze on 02.07.25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .systemBackground

        let rootVC = ViewController()
        let navController = UINavigationController(rootViewController: rootVC)

        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        return true
    }
}
