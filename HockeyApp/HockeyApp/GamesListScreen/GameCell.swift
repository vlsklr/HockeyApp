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
        backgroundColor = .white
    }
    
    func setupArena() {
        contentView.addSubview(arena)
        arena.textColor = .black
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
        homeTeamLogo.image = UIImage()
        homeTeamLogo.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(contentView.bounds.width * 0.01)
            make.top.equalToSuperview().offset(25)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
    }
    
    func setupHomeTeamName() {
        contentView.addSubview(homeTeamNameLabel)
        homeTeamNameLabel.textColor = .black
        homeTeamNameLabel.textAlignment = .center
        homeTeamNameLabel.font = homeTeamNameLabel.font.withSize(25)
        homeTeamNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(contentView.bounds.width * 0.01)
            make.top.equalTo(homeTeamLogo.snp_bottomMargin).offset(15)
            make.width.equalTo(homeTeamLogo)
            make.height.equalTo(25)
        }
    }
    
    func setupVisitorTeamLogo() {
        contentView.addSubview(visitorTeamLogo)
        visitorTeamLogo.image = UIImage()
        visitorTeamLogo.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(contentView.bounds.width * -0.01)
            make.top.equalToSuperview().offset(25)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
    }
    
    func setupVisitiorTeamName() {
        contentView.addSubview(visitorTeamNameLabel)
        visitorTeamNameLabel.textColor = .black
        visitorTeamNameLabel.textAlignment = .center
        visitorTeamNameLabel.font = visitorTeamNameLabel.font.withSize(25)
        visitorTeamNameLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(contentView.bounds.width * -0.01)
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
        scores.text = "- : -"
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
        gameDate.text = game.gamedate
        if let homeScores = game.homeScores, let visitorScores = game.visitorScores {
            scores.text = "\(homeScores) : \(visitorScores)"
        }
        arena.text = game.arena
        if let homeTeamImage = game.homeTeam.logoImage {
            homeTeamLogo.image = homeTeamImage
        }
        if let visitorTeamImage = game.visitorTeam.logoImage {
            visitorTeamLogo.image = visitorTeamImage
        }
    }
}
