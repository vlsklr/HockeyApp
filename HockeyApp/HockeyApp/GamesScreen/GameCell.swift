//
//  GameCell.swift
//  HockeyApp
//
//  Created by Vlad on 21.11.2021.
//

import SnapKit
import UIKit

protocol IGameCell {
    func setInfo(game: GameModel)
}

class GameCell: UITableViewCell {
    let homeTeamNameLabel = UILabel()
    let visitorTeamNameLabel = UILabel()
    let homeTeamLogo = UIImageView()
    let visitorTeamLogo = UIImageView()
    let gameDate = UILabel()
    let scores = UILabel()
    let arena = UILabel()
    let selectedView = UIView()
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        //        contentView.backgroundColor = .green
    }
    
    
    
    func setupCell() {
        setupArena()
        setupGameDate()
        setupHomeTeamLogo()
        setupHomeTeamName()
        setupVisitorTeamLogo()
        setupVisitiorTeamName()
        setupScores()
        selectedView.backgroundColor = .red
        selectedBackgroundView = selectedView
        //        contentView.backgroundColor = .white
    }
    
    func setupArena() {
        contentView.addSubview(arena)
        arena.textColor = .black
        arena.text = "ЛДС Бердск"
        arena.font = arena.font.withSize(20)
        arena.textAlignment = .center
        arena.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(100)
            make.trailing.equalToSuperview().offset(-100)
            make.top.equalToSuperview().offset(35)
            make.width.equalToSuperview().offset(-200)
            make.height.equalTo(15)
        }
    }
    
    func setupGameDate() {
        contentView.addSubview(gameDate)
        gameDate.textColor = .black
        gameDate.textAlignment = .center
        gameDate.font = gameDate.font.withSize(15)
        gameDate.text = "14 февраля 15:00"
        gameDate.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(100)
            make.trailing.equalToSuperview().offset(-100)
            make.top.equalTo(arena).offset(35)
            make.width.equalToSuperview().offset(-200)
            make.height.equalTo(15)
        }
    }
    
    func setupHomeTeamLogo() {
        contentView.addSubview(homeTeamLogo)
        //        homeTeamLogo.backgroundColor = .green
        homeTeamLogo.image = UIImage(named: "photo_70")
        homeTeamLogo.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(25)
            make.width.equalTo(75)
            make.height.equalTo(75)
        }
        
    }
    
    func setupHomeTeamName() {
        contentView.addSubview(homeTeamNameLabel)
        homeTeamNameLabel.textColor = .black
        homeTeamNameLabel.textAlignment = .center
        homeTeamNameLabel.font = homeTeamNameLabel.font.withSize(25)
        homeTeamNameLabel.text = "ЛГН"
        homeTeamNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            //            make.trailing.equalToSuperview().offset(-100)
            make.top.equalTo(homeTeamLogo.snp_bottomMargin).offset(15)
            make.width.equalTo(homeTeamLogo)
            make.height.equalTo(25)
        }
    }
    
    func setupVisitorTeamLogo() {
        contentView.addSubview(visitorTeamLogo)
        visitorTeamLogo.image = UIImage(named: "photo_70")
        //        visitorTeamLogo.backgroundColor = .red
        
        visitorTeamLogo.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(25)
            make.width.equalTo(75)
            make.height.equalTo(75)
        }
    }
    
    func setupVisitiorTeamName() {
        contentView.addSubview(visitorTeamNameLabel)
        visitorTeamNameLabel.textColor = .black
        visitorTeamNameLabel.textAlignment = .center
        visitorTeamNameLabel.font = visitorTeamNameLabel.font.withSize(25)
        visitorTeamNameLabel.text = "ЛГН"
        
        visitorTeamNameLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(visitorTeamLogo.snp_bottomMargin).offset(15)
            make.width.equalTo(visitorTeamLogo)
            make.height.equalTo(25)
        }
    }
    
    func setupScores() {
        contentView.addSubview(scores)
        scores.textAlignment = .center
        scores.textColor = .black
        scores.font = scores.font.withSize(35)
        scores.text = "0 : 0"
        scores.snp.makeConstraints { make in
            make.leading.equalTo(homeTeamLogo).offset(15)
            make.trailing.equalTo(visitorTeamLogo).offset(-15)
            make.bottom.equalTo(homeTeamNameLabel)
            make.height.equalTo(25)
            make.width.equalTo(50)
        }
    }
}

extension GameCell: IGameCell {
    func setInfo(game: GameModel) {
        homeTeamNameLabel.text = game.homeTeam.shortName
        visitorTeamNameLabel.text = game.visitorTeam.shortName
    }
    
    
}
