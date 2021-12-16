//
//  GameInfoPresenter.swift
//  HockeyApp
//
//  Created by Admin on 15.12.2021.
//

import Foundation

protocol IGameInfoPresenter: AnyObject {
    func getGameInfo()
}

class GameInfoPresenter: IGameInfoPresenter {
    
    weak var view: IGameInfoViewController?
    let interactor: IGameInfoInteractor
    let game: GameModel
    
    init(interactor: IGameInfoInteractor, game: GameModel) {
        self.interactor = interactor
        self.game = game
    }
    
    func getGameInfo() {
        interactor.getGameInfo(url: "https://sibhl.ru", game: game)
    }
    
    
    
    
}
