//
//  GamesInteractor.swift
//  HockeyApp
//
//  Created by Admin on 30.11.2021.
//

import Foundation
import UIKit

protocol IGamesInteractor: AnyObject {
    func getMatchesList()
}

class GamesInteractor: IGamesInteractor {
    weak var presenter: IGamesPresenter?
    let networkManager: INetworkManager
    
    init(networkManager: INetworkManager) {
        self.networkManager = networkManager
    }
    // Пока оставляю как временное решение, возможно потом буду загружать все иконки из облака и выставлять по названию команды. Не очень нравится постоянный reload tableView
    func loadImages(games: [GameModel]) {
        var gamesList = games
        for index in 0...gamesList.count - 1 {
            networkManager.loadInfo(url: gamesList[index].homeTeam.logoLink ?? "") { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    let img = UIImage(data: data)
                    gamesList[index].homeTeam.logoImage = img
                    self.presenter?.setLoadedMatches(matches: gamesList)
                }
            }
            networkManager.loadInfo(url: gamesList[index].visitorTeam.logoLink ?? "") { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    let img = UIImage(data: data)
                    gamesList[index].visitorTeam.logoImage = img
                    self.presenter?.setLoadedMatches(matches: gamesList)
                }
            }
        }
    }
    
    func getMatchesList() {
        networkManager.loadGames(url: "https://sibhl.ru") { games in
            self.loadImages(games: games)
//            self.presenter?.setLoadedMatches(matches: games)
        }
    }
}
