//
//  GamesInteractor.swift
//  HockeyApp
//
//  Created by Admin on 30.11.2021.
//

import Foundation

protocol IGamesInteractor: AnyObject {
    
}

class GamesInteractor: IGamesInteractor {
    weak var presenter: IGamesPresenter?
    let networkManager: INetworkManager
    
    init(networkManager: INetworkManager) {
        self.networkManager = networkManager
    }
}
