//
//  MainTabBarController.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/11/22.
//

import UIKit

class MainTabBarController: UITabBarController {

    let home = HomeCoordinator(navigationController: UINavigationController())
    let settings = SettingsCoordinator(navigationController: UINavigationController())
    let profile = ProfileCoordinator(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        
        home.start()
        settings.start()
        profile.start()
        
        let nav1 = home.navigationController
        let nav3 = settings.navigationController
        let nav2 = profile.navigationController
        
        nav1.navigationBar.tintColor = .white
        nav2.navigationBar.tintColor = .white
        nav3.navigationBar.tintColor = .white
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        
        nav1.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), tag: 1)
        nav3.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "gearshape"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person"), tag: 1)
        
        setViewControllers([nav1,nav2,nav3], animated: false)
        
        UITabBar.appearance().barTintColor = .systemBackground
        UITabBar.appearance().tintColor = .white
    }
}

