//
//  GameInfoAssembly.swift
//  HockeyApp
//
//  Created by Admin on 15.12.2021.
//

import Foundation

class GameInfoAssembly {
    func build(game: GameModel) -> GameInfoViewController {
        let router = GameInfoRouter()
        let interactor = GameInfoInteractor()
        let presenter = GameInfoPresenter(interactor: interactor, game: game)
        let view = GameInfoViewController(presenter: presenter)
        presenter.view = view
        router.view = view
        interactor.presenter = presenter
        presenter.getGameInfo()
        return view
    }
}
