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
    func refreshTable()

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
    let cupName = UILabel()
    let eventsView = UITableView()
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
        eventsView.dataSource = self
        eventsView.delegate = self
        setHomeTeamLogo()
        setHomeTeamNameLabel()
        setVisitorTeamLogo()
        setVisitorNameLabel()
        setStadiumLabel()
        setScoresLablel()
        setCupName()
        setEventsView()
    }
    
    func setHomeTeamLogo() {
        view.addSubview(homeTeamLogo)
        homeTeamLogo.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(25)
            make.width.equalTo(85)
            make.height.equalTo(85)
        }
        
    }
    
    func setHomeTeamNameLabel() {
        view.addSubview(homeTeamName)
        homeTeamName.numberOfLines = 0
        homeTeamName.textColor = .black
        homeTeamName.font = homeTeamName.font.withSize(15)
        homeTeamName.textAlignment = .center
        homeTeamName.snp.makeConstraints { make in
            make.top.equalTo(homeTeamLogo.snp_bottomMargin).offset(-20)
            make.leading.equalTo(homeTeamLogo)
            make.width.equalTo(85)
            make.height.equalTo(85)
        }
    }
    
    func setVisitorTeamLogo() {
        view.addSubview(visitorTeamLogo)
        visitorTeamLogo.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-25)
            make.top.equalToSuperview().offset(100)
            make.width.equalTo(85)
            make.height.equalTo(85)
        }
    }
    
    func setVisitorNameLabel() {
        view.addSubview(visitorTeamName)
        visitorTeamName.numberOfLines = 0
        visitorTeamName.textColor = .black
        visitorTeamName.font = visitorTeamName.font.withSize(15)
        visitorTeamName.textAlignment = .center
        visitorTeamName.snp.makeConstraints { make in
            make.top.equalTo(visitorTeamLogo.snp_bottomMargin).offset(-20)
            make.leading.equalTo(visitorTeamLogo)
            make.width.equalTo(85)
            make.height.equalTo(85)
        }
    }
    
    func setStadiumLabel() {
        view.addSubview(stadiumName)
        stadiumName.textAlignment = .center
        stadiumName.textColor = .black
        stadiumName.snp.makeConstraints { make in
            make.top.equalTo(visitorTeamLogo.snp.centerY).offset(-20)
            make.centerX.equalTo(self.view)
        }
    }
    
    func setScoresLablel() {
        view.addSubview(scores)
        scores.textAlignment = .center
        scores.font = scores.font.withSize(20)
        scores.textColor = .black
        scores.snp.makeConstraints { make in
            make.top.equalTo(stadiumName.snp_bottomMargin).offset(20)
            make.centerX.equalTo(self.view)
        }
        
    }
    
    func setCupName() {
        view.addSubview(cupName)
        cupName.textAlignment = .center
        cupName.font = cupName.font.withSize(13)
        cupName.textColor = .black
        cupName.snp.makeConstraints { make in
            make.top.equalTo(scores.snp_bottomMargin).offset(20)
            make.centerX.equalTo(self.view)
        }
    }
    
    func setEventsView() {
        view.addSubview(eventsView)
//        eventsView.backgroundColor = .blue
        eventsView.register(EventCell.self, forCellReuseIdentifier: "event")
        eventsView.snp.makeConstraints { make in
            make.top.equalTo(visitorTeamName).offset(75)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50)
        }
    }
}

extension GameInfoViewController: IGameInfoViewController {
    func refreshTable() {
        eventsView.reloadData()
    }
    
    func showGameInfo(game: GameModel) {
        guard let homeTeamNameText = game.homeTeam.name, let visitorTeamNameText = game.visitorTeam.name, let homeScores = game.homeScores, let visitorScores = game.visitorScores, let cupName = game.cupName else { return }
        DispatchQueue.main.async {
            self.homeTeamName.text = homeTeamNameText
            self.visitorTeamName.text = visitorTeamNameText
            self.visitorTeamLogo.image = game.visitorTeam.logoImage
            self.homeTeamLogo.image = game.homeTeam.logoImage
            self.stadiumName.text = game.arena
            self.scores.text = "\(homeScores) : \(visitorScores)"
            self.cupName.text = cupName
            self.refreshTable()
        }
    }
}

extension GameInfoViewController: UITableViewDelegate {
    
}

extension GameInfoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.00
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getEventsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "event") as! EventCell
        presenter.setEventInfoToCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    
}
