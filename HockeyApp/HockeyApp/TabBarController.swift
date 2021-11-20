//
//  TabBarController.swift
//  HockeyApp
//
//  Created by Vlad on 20.11.2021.
//

import UIKit

class TabBarController {
    
    
    
    private let tabBar: UITabBarController
    private let gamesListNavigationController: UINavigationController
    private let gamesListScreenViewController: GamesViewController
    private let tablesNavigationController: UINavigationController
    private let tablesScreenViewController: TablesViewController
    
    
    init() {
        self.tabBar = UITabBarController()
        tabBar.tabBar.barTintColor =  UIColor(red: 0.243, green: 0.776, blue: 1, alpha: 1)
        
        self.gamesListScreenViewController = GamesViewController()
        self.gamesListNavigationController = UINavigationController(rootViewController: self.gamesListScreenViewController)
        self.gamesListNavigationController.tabBarItem.title = "123"
        tablesScreenViewController = TablesViewController()
        tablesNavigationController = UINavigationController(rootViewController: tablesScreenViewController)
        tablesNavigationController.tabBarItem.title = "345"
        
        self.tabBar.setViewControllers([gamesListNavigationController, tablesNavigationController], animated: true)
    }
    func getTabBar() -> UITabBarController {
        return self.tabBar
    }
}
