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
    func getMatchData(indexPath: IndexPath) -> GameModel?
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
    
    func getMatchData(indexPath: IndexPath) -> GameModel? {
        return matches?[indexPath.row]
    }
    
}
