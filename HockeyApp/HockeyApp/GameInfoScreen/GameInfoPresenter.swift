//
//  GameInfoPresenter.swift
//  HockeyApp
//
//  Created by Admin on 15.12.2021.
//

import Foundation

protocol IGameInfoPresenter: AnyObject {
    func getGameInfo()
    func setGameInfo(game: GameModel)
    func getEventsCount() -> Int
    func setEventInfoToCell(cell: IEventCell, indexPath: IndexPath)
    func getEventSide(indexPath: IndexPath) -> Bool
}

class GameInfoPresenter: IGameInfoPresenter {
    
    weak var view: IGameInfoViewController?
    let interactor: IGameInfoInteractor
    var game: GameModel
    
    init(interactor: IGameInfoInteractor, game: GameModel) {
        self.interactor = interactor
        self.game = game
    }
    
    func getGameInfo() {
        interactor.getGameInfo(url: "https://sibhl.ru", game: game)
    }
    
    func setGameInfo(game: GameModel) {
        self.game = game
        view?.showGameInfo(game: game)
    }
    
    func getEventsCount() -> Int {
        return game.events?.count ?? 0
    }
    
    func setEventInfoToCell(cell: IEventCell, indexPath: IndexPath) {
        guard let event = game.events?[indexPath.row] else { return }
        cell.setupCell(event: event)
    }
    
    func getEventSide(indexPath: IndexPath) -> Bool {
        guard let event = game.events?[indexPath.row] else { return false }
        return event.isHomeTeamEvent
    }
}
