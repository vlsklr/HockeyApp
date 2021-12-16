//
//  GameInfoInteractor.swift
//  HockeyApp
//
//  Created by Admin on 15.12.2021.
//

import Foundation


protocol IGameInfoInteractor {
    func getGameInfo(url: String, game: GameModel)
    
}

class GameInfoInteractor: IGameInfoInteractor {
    
    weak var presenter: IGameInfoPresenter?
    let networkManager: INetworkManager = NetworkManager()
    
    func getGameInfo(url: String, game: GameModel) {
        networkManager.loadGameInfo(url: url, game: game) { game in
            print(game)
        }
    }
}
