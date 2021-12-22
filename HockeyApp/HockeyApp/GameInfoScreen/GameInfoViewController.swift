//
//  GameInfoViewController.swift
//  HockeyApp
//
//  Created by Admin on 15.12.2021.
//

import Foundation
import UIKit
import SnapKit

protocol IGameInfoViewController: AnyObject {
    func showGameInfo(game: GameModel)

}


class GameInfoViewController: UIViewController {
    let presenter: IGameInfoPresenter
    let homeTeamName = UILabel()
    let visitorTeamName = UILabel()
    let homeTeamScore = UILabel()
    let visitorTeamScore = UILabel()
    let homeTeamLogo = UIImageView()
    let visitorTeamLogo = UIImageView()
    
    init(presenter: IGameInfoPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        setHomeTeamNameLabel()
    }
    
    func setHomeTeamNameLabel() {
        view.addSubview(homeTeamName)
        homeTeamName.text = "Хозяева"
        homeTeamName.textColor = .black
        homeTeamName.font = homeTeamName.font.withSize(15)
        homeTeamName.textAlignment = .center
        homeTeamName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.leading.equalToSuperview().offset(50)
            make.width.equalTo(75)
            make.height.equalTo(50)
        }
        
    }
}

extension GameInfoViewController: IGameInfoViewController {
    func showGameInfo(game: GameModel) {
        guard let homeTeamNameText = game.visitorTeam.name else { return }
//        print()
        DispatchQueue.main.async {
            self.homeTeamName.text = homeTeamNameText
        }
    }
    
    
}
