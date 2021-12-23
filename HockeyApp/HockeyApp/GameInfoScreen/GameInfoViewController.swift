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
    let stadiumName = UILabel()
    let scores = UILabel()
    
    init(presenter: IGameInfoPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        tabBarController?.tabBar.isHidden = true
        setHomeTeamLogo()
        setHomeTeamNameLabel()
        setVisitorTeamLogo()
        setVisitorNameLabel()
        setStadiumLabel()
        setScoresLablel()
    }
    
    func setHomeTeamLogo() {
        view.addSubview(homeTeamLogo)
//        homeTeamLogo.image = UIImage(named: "photo_70")
        homeTeamLogo.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(125)
            make.leading.equalToSuperview().offset(25)
            make.width.equalTo(85)
            make.height.equalTo(85)
        }
        
    }
    
    func setHomeTeamNameLabel() {
        view.addSubview(homeTeamName)
        homeTeamName.numberOfLines = 0
//        homeTeamName.text = "Хозяева"
        homeTeamName.textColor = .black
        homeTeamName.font = homeTeamName.font.withSize(15)
        homeTeamName.textAlignment = .center
        homeTeamName.snp.makeConstraints { make in
            make.top.equalTo(homeTeamLogo.snp_bottomMargin).offset(5)
            make.leading.equalTo(homeTeamLogo)
            make.width.equalTo(85)
            make.height.equalTo(85)
        }
    }
    
    func setVisitorTeamLogo() {
        view.addSubview(visitorTeamLogo)
//        visitorTeamLogo.image = UIImage(named: "photo_70")
        visitorTeamLogo.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-25)
            make.top.equalToSuperview().offset(125)
            make.width.equalTo(85)
            make.height.equalTo(85)
        }
        
    }
    
    func setVisitorNameLabel() {
        view.addSubview(visitorTeamName)
        visitorTeamName.numberOfLines = 0
//        visitorTeamName.text = "Хозяева"
        visitorTeamName.textColor = .black
        visitorTeamName.font = visitorTeamName.font.withSize(15)
        visitorTeamName.textAlignment = .center
        visitorTeamName.snp.makeConstraints { make in
            make.top.equalTo(visitorTeamLogo.snp_bottomMargin).offset(5)
            make.leading.equalTo(visitorTeamLogo)
            make.width.equalTo(85)
            make.height.equalTo(85)
        }
    }
    
    func setStadiumLabel() {
        view.addSubview(stadiumName)
        stadiumName.textAlignment = .center
        stadiumName.snp.makeConstraints { make in
            make.top.equalTo(visitorTeamLogo.snp.centerY).offset(-20)
            make.centerX.equalTo(self.view)
        }
    }
    
    func setScoresLablel() {
        view.addSubview(scores)
        scores.textAlignment = .center
        scores.snp.makeConstraints { make in
            make.top.equalTo(stadiumName).offset(20)
            make.centerX.equalTo(self.view)
        }
        
    }
}

extension GameInfoViewController: IGameInfoViewController {
    func showGameInfo(game: GameModel) {
        guard let homeTeamNameText = game.homeTeam.name, let visitorTeamNameText = game.visitorTeam.name, let homeScores = game.homeScores, let visitorScores = game.visitorScores else { return }
//        print()
        DispatchQueue.main.async {
            self.homeTeamName.text = homeTeamNameText
            self.visitorTeamName.text = visitorTeamNameText
            self.visitorTeamLogo.image = game.visitorTeam.logoImage
            self.homeTeamLogo.image = game.homeTeam.logoImage
            self.stadiumName.text = game.arena
            self.scores.text = "\(homeScores) : \(visitorScores)"
        }
    }
    
    
}
