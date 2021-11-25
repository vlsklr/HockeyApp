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
        tabBar.tabBar.barTintColor = .red
        
        self.gamesListScreenViewController = GamesViewController()
        self.gamesListNavigationController = UINavigationController(rootViewController: self.gamesListScreenViewController)
        self.gamesListNavigationController.tabBarItem.title = "Матчи"
        tablesScreenViewController = TablesViewController()
        tablesNavigationController = UINavigationController(rootViewController: tablesScreenViewController)
        tablesNavigationController.tabBarItem.title = "Таблицы"
        
        self.tabBar.setViewControllers([gamesListNavigationController, tablesNavigationController], animated: true)
    }
    func getTabBar() -> UITabBarController {
        return self.tabBar
    }
}
