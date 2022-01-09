//
//  TablesAssembly.swift
//  HockeyApp
//
//  Created by Admin on 04.01.2022.
//

import Foundation

class TablesAssembly {
    
    func build() -> TablesViewController {
        let interactor = TablesInteractor()
        let presenter = TablesPresenter(interactor: interactor)
        let view = TablesViewController(presenter: presenter)
        interactor.presenter = presenter
        presenter.view = view
        return view
    }
    
}
