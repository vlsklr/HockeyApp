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
        networkManager.loadGameInfo(url: url, game: game) { result in
            switch result {
            case .success(let gameInfo):
                self.presenter?.setGameInfo(game: gameInfo)
            case .failure(let error):
                print(error)
                self.presenter?.notifyError(errorMessage: error.localizedDescription)
            }
        }
    }
}
