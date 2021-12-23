//
//  GamesPresenter.swift
//  HockeyApp
//
//  Created by Admin on 30.11.2021.
//

import Foundation

protocol IGamesPresenter: AnyObject {
    func setLoadedMatches(matches: [GameModel])
    func getMatchesCount() -> Int
    func getMatchData(indexPath: IndexPath, cell: IGameCell)
    func showMatch(indexPath: IndexPath)
    
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
    
    func getMatchesCount() -> Int {
        matches?.count ?? 0
    }
    
    func setLoadedMatches(matches: [GameModel]) {
        self.matches = matches
        view?.refreshView()
    }
    
    func getMatchData(indexPath: IndexPath, cell: IGameCell) {
        guard let game = matches?[indexPath.row] else {
            return
        }
        cell.setInfo(game: game)        
    }
    
    func showMatch(indexPath: IndexPath) {
        guard let match = matches?[indexPath.row] else { return }
        router.showMatchInfo(game: match)
    }
    
}
