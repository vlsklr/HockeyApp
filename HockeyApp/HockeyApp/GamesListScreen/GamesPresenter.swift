//
//  GamesPresenter.swift
//  HockeyApp
//
//  Created by Admin on 30.11.2021.
//

import Foundation
import UIKit

protocol IGamesPresenter: AnyObject {
    func setLoadedMatches(matches: [GameModel])
    func getMatchesCount() -> Int
    func getMatchData(indexPath: IndexPath, cell: IGameCell)
    func showMatch(indexPath: IndexPath)
    func updateGamesList()
    func notifyError(text: String)
}

class GamesPresenter: IGamesPresenter {
    
    var router: IGamesRouter
    var interactor: IGamesInteractor
    weak var view: IGamesViewController?
    var matches: [GameModel]?
    
    init(router: IGamesRouter, interactor: IGamesInteractor) {
        self.router = router
        self.interactor = interactor
        interactor.getMatchesList()
    }
    
    func updateGamesList() {
        interactor.getMatchesList()
    }
    
    func getMatchesCount() -> Int {
        matches?.count ?? 0
    }
    
    func setLoadedMatches(matches: [GameModel]) {
        self.matches = matches
        view?.refreshView()
    }
    
    func getMatchData(indexPath: IndexPath, cell: IGameCell) {
        guard let count = matches?.count, let game = matches?[(count - 1) - indexPath.row] else {
            return
        }
        cell.setInfo(game: game)        
    }
    
    func showMatch(indexPath: IndexPath) {
        guard let count = matches?.count, let match = matches?[(count - 1) - indexPath.row] else { return }
        router.showMatchInfo(game: match)
    }
    
    func notifyError(text: String) {
        AlertController.showAlert(text: Texts.errorMessage.rawValue, view: view as! UIViewController)
    }
    
}
