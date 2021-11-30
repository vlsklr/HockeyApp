//
//  GamesPresenter.swift
//  HockeyApp
//
//  Created by Admin on 30.11.2021.
//

import Foundation

protocol IGamesPresenter: AnyObject {
    
}

class GamesPresenter: IGamesPresenter {
    var router: IGamesRouter
    var interactor: IGamesInteractor
    weak var view: IGamesViewController?
    
    init(router: IGamesRouter, interactor: IGamesInteractor) {
        self.router = router
        self.interactor = interactor
    }
}
