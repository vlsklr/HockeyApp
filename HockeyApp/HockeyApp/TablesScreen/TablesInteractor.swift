//
//  TablesInteractor.swift
//  HockeyApp
//
//  Created by Admin on 04.01.2022.
//

import Foundation

protocol ITablesInteractor: AnyObject {
    func getTeamsStanding()
}

class TablesInteractor: ITablesInteractor {
    
    weak var presenter: ITablesPresenter?
    let networkManager = NetworkManager()
    
    func getTeamsStanding() {
        networkManager.loadTables(Texts.siteTablesLink.rawValue) { teamsStats in
            self.presenter?.setTablesInfo(tables: teamsStats)
        }
    }
}
