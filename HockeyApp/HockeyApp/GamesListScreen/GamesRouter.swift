//
//  GamesRouter.swift
//  HockeyApp
//
//  Created by Admin on 30.11.2021.
//

import Foundation

protocol IGamesRouter: AnyObject {
    func showMatchInfo(game: GameModel)
}

class GamesRouter: IGamesRouter {
    
    weak var view: IGamesViewController?
    
    func showMatchInfo(game: GameModel) {
        let vc = GameInfoAssembly().build(game: game)
        view?.showGame(viewController: vc)
    }
    
}
