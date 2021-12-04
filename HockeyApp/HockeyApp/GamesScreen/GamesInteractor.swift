//
//  GamesInteractor.swift
//  HockeyApp
//
//  Created by Admin on 30.11.2021.
//

import Foundation

protocol IGamesInteractor: AnyObject {
    func getMatchesList()
}

class GamesInteractor: IGamesInteractor {
    weak var presenter: IGamesPresenter?
    let networkManager: INetworkManager
    
    init(networkManager: INetworkManager) {
        self.networkManager = networkManager
    }
    
    func getMatchesList() {
        networkManager.loadGames(url: "https://sibhl.ru") { games in
            self.presenter?.setLoadedMatches(matches: games)
        }
    }
}
