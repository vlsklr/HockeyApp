//
//  GameInfoViewController.swift
//  HockeyApp
//
//  Created by Admin on 15.12.2021.
//

import Foundation
import UIKit

protocol IGameInfoViewController: AnyObject {
    
}


class GameInfoViewController: UIViewController {
    let presenter: IGameInfoPresenter
        
    init(presenter: IGameInfoPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = .green
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

extension GameInfoViewController: IGameInfoViewController {
    
}
