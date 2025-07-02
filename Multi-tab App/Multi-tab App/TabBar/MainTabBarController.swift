//
//  MainTabBarController.swift
//  Multi-tab App
//
//  Created by ana namgaladze on 02.07.25.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    static func create() -> MainTabBarController {
        let tabBarController = MainTabBarController()
        
        let onboardingNav = UINavigationController(rootViewController: OnboardingViewController())
        onboardingNav.tabBarItem = UITabBarItem(title: "Onboarding", image: UIImage(systemName: "figure.walk"), selectedImage: nil)
        
        let profileNav = UINavigationController(rootViewController: ProfileViewController())
        profileNav.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), selectedImage: nil)
        
        let settingsVC = SettingsViewController()
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape"), selectedImage: nil)
        
        tabBarController.viewControllers = [onboardingNav, profileNav, settingsVC]
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .orange
        tabBarController.tabBar.standardAppearance = appearance
        tabBarController.tabBar.scrollEdgeAppearance = appearance
        tabBarController.tabBar.tintColor = .white
        tabBarController.tabBar.unselectedItemTintColor = .gray
        
        return tabBarController
    }
}
