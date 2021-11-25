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
        tabBar = UITabBarController()
        tabBar.tabBar.barTintColor =  .red
        
        gamesListScreenViewController = GamesViewController()
        gamesListNavigationController = UINavigationController(rootViewController: self.gamesListScreenViewController)
        gamesListNavigationController.tabBarItem.title = "Матчи"
        gamesListNavigationController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        tablesScreenViewController = TablesViewController()
        tablesNavigationController = UINavigationController(rootViewController: tablesScreenViewController)
        tablesNavigationController.tabBarItem.title = "Таблицы"
//        tablesNavigationController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "American Typewriter", size: 25)], for: .normal)
        tablesNavigationController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        tabBar.setViewControllers([gamesListNavigationController, tablesNavigationController], animated: true)
    }
    func getTabBar() -> UITabBarController {
        return tabBar
    }
}
