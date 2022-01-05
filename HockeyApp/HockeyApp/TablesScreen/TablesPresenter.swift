//
//  TablesPresenter.swift
//  HockeyApp
//
//  Created by Admin on 04.01.2022.
//

import Foundation

protocol ITablesPresenter: AnyObject {
    func setupCell(teamCell: ITablesCell, for index: Int)
    func getInfo()
    func setTablesInfo(tables: [TeamStatsModel])
    func getTeamsCount() -> Int
}

class TablesPresenter: ITablesPresenter {
    
    weak var view: ITablesViewController?
    let interactor: ITablesInteractor
    var tables: [TeamStatsModel]?
    
    init(interactor: ITablesInteractor) {
        self.interactor = interactor
        interactor.getTeamsStanding()
    }
    
    func getInfo() {
        interactor.getTeamsStanding()
    }
    
    func setupCell(teamCell: ITablesCell, for index: Int) {
        guard let teamInfo = tables?[index] else { return }
        teamCell.setupCell(teamInfo: teamInfo)
        
    }
    
    func setTablesInfo(tables: [TeamStatsModel]) {
        self.tables = tables
    }
    
    func getTeamsCount() -> Int {
        return tables?.count ?? 0
    }

}
