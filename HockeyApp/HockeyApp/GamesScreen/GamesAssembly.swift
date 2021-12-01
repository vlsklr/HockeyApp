//
//  GamesAssembly.swift
//  HockeyApp
//
//  Created by Admin on 30.11.2021.
//

import Foundation


class GamesAssembly {
    
    func build() -> GamesViewController {
        let router = GamesRouter()
        let networkManager = NetworkManager()
        let interactor = GamesInteractor(networkManager: networkManager)
        let presenter = GamesPresenter(router: router, interactor: interactor)
        interactor.presenter = presenter
        let view = GamesViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}
