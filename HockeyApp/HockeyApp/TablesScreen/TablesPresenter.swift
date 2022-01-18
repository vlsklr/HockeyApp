//
//  TablesPresenter.swift
//  HockeyApp
//
//  Created by Admin on 04.01.2022.
//

import Foundation
import UIKit

protocol ITablesPresenter: AnyObject {
    func setupCell(teamCell: ITablesCell, for index: Int)
    func getInfo()
    func setTablesInfo(tables: [TeamStatsModel])
    func getTeamsCount() -> Int
    func notifyError(text: String)
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
        guard let teamsInfo = tables else { return }
        teamCell.setupCell(teamsInfo: teamsInfo, numberOfRow: index)
    }
    
    func setTablesInfo(tables: [TeamStatsModel]) {
        self.tables = tables
    }
    
    func getTeamsCount() -> Int {
        return tables?.count ?? 0
    }
    
    func notifyError(text: String) {
        view?.alertController.showAlert(text: Texts.errorMessage.rawValue)        
//        AlertController.showAlert(text: Texts.errorMessage.rawValue, view: view as! UIViewController)
    }
}
