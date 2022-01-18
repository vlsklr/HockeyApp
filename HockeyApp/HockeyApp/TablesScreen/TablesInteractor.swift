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
        networkManager.loadTables(Texts.siteTablesLink.rawValue) { result in
            switch result {
            case .success(let teamStats):
                self.presenter?.setTablesInfo(tables: teamStats)
            case .failure(let error):
                self.presenter?.notifyError(text: error.localizedDescription)
            }
        }
    }
}
