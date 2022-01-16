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
        
        gamesListScreenViewController = GamesAssembly().build()
        gamesListNavigationController = UINavigationController(rootViewController: self.gamesListScreenViewController)
        gamesListNavigationController.tabBarItem.title = Texts.games.rawValue
        gamesListNavigationController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        tablesScreenViewController = TablesAssembly().build()
        tablesNavigationController = UINavigationController(rootViewController: tablesScreenViewController)
        tablesNavigationController.tabBarItem.title = Texts.tables.rawValue
        tablesNavigationController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        tabBar.setViewControllers([gamesListNavigationController, tablesNavigationController], animated: true)
    }
    func getTabBar() -> UITabBarController {
        return tabBar
    }
}
