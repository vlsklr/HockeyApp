//
//  GameCell.swift
//  HockeyApp
//
//  Created by Vlad on 21.11.2021.
//

import SnapKit
import UIKit

class GameCell: UITableViewCell {
    let homeTeamNameLabel = UILabel()
    let visitorTeamNameLabel = UILabel()
    let homeTeamLogo = UIImageView()
    let visitorTeamLogo = UIImageView()
    let gameDate = UILabel()
    let scores = UILabel()
    let arena = UILabel()
    
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
    }
    
    func setupArena() {
        contentView.addSubview(arena)
        arena.textColor = .black
        arena.text = "ЛДС Бердск"
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
        gameDate.text = "14.02.1994 - 15.00"
        gameDate.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(100)
            make.trailing.equalToSuperview().offset(-100)
            make.top.equalTo(arena).offset(25)
            make.width.equalToSuperview().offset(-200)
            make.height.equalTo(15)
        }
    }
    
    func setupHomeTeamLogo() {
        contentView.addSubview(homeTeamLogo)
        homeTeamLogo.backgroundColor = .green
        
        homeTeamLogo.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(25)
            make.width.equalTo(75)
            make.height.equalTo(75)
        }
        
    }
    
    func setupHomeTeamName() {
        contentView.addSubview(homeTeamNameLabel)
        homeTeamNameLabel.textColor = .black
        homeTeamNameLabel.textAlignment = .center
        homeTeamNameLabel.text = "ЛГН"
        homeTeamNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
//            make.trailing.equalToSuperview().offset(-100)
            make.top.equalTo(homeTeamLogo.snp_bottomMargin).offset(15)
            make.width.equalTo(homeTeamLogo)
            make.height.equalTo(25)
        }
    }
    
    func setupVisitorTeamLogo() {
        contentView.addSubview(visitorTeamLogo)
        visitorTeamLogo.backgroundColor = .red
        visitorTeamLogo.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(25)
            make.width.equalTo(75)
            make.height.equalTo(75)
        }
    }
    
    func setupVisitiorTeamName() {
        contentView.addSubview(visitorTeamNameLabel)
        visitorTeamNameLabel.textColor = .black
        visitorTeamNameLabel.textAlignment = .center
        visitorTeamNameLabel.text = "ЛГН"
        visitorTeamNameLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalTo(visitorTeamLogo.snp_bottomMargin).offset(15)
            make.width.equalTo(visitorTeamLogo)
            make.height.equalTo(25)
        }
    }
    
    func setupScores() {
        contentView.addSubview(scores)
        scores.textAlignment = .center
        scores.textColor = .black
        scores.text = "0 : 0"
        scores.snp.makeConstraints { make in
            make.leading.equalTo(homeTeamLogo).offset(15)
            make.trailing.equalTo(visitorTeamLogo).offset(-15)
            make.top.equalTo(gameDate).offset(20)
            make.height.equalTo(25)
            make.width.equalTo(50)
        }
    }
}
