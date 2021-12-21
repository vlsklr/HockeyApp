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
    
    
    
    
}
