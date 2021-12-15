//
//  GamesRouter.swift
//  HockeyApp
//
//  Created by Admin on 30.11.2021.
//

import Foundation

protocol IGamesRouter: AnyObject {
    func showMatchInfo()
}

class GamesRouter: IGamesRouter {
    
    weak var view: IGamesViewController?
    
    func showMatchInfo() {
        let vc = GameInfoAssembly().build()
        view?.showGame(viewController: vc)
    }
    
}
