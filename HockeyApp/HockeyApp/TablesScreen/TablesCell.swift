//
//  TablesCell.swift
//  HockeyApp
//
//  Created by Admin on 05.01.2022.
//

import Foundation
import UIKit
import SnapKit

protocol ITablesCell: AnyObject {
    func setupCell(teamInfo: TeamStatsModel)
}

class TablesCell: UITableViewCell, ITablesCell {
    
    let scrollView = UIScrollView()
    let nameLabel = UILabel()
    let positionLabel = UILabel()
    let gamesLabel = UILabel()
    let winsLabel = UILabel()
    let overtimeWinsLabel = UILabel()
    let shoutoutWinsLabel = UILabel()
    let overtimeLosesLabel = UILabel()
    let shoutoutLosesLabel = UILabel()
    let losesLabel = UILabel()
    let goalsLabel = UILabel()
    let pointsLabel = UILabel()
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        print("selected")
//    }
    
    func setupScrollView() {
        contentView.backgroundColor = .red
        scrollView.backgroundColor = .green
        contentView.addSubview(scrollView)
        
        scrollView.contentSize = CGSize(width:700, height: 150)
        scrollView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setupTeamPositionLabel() {
        scrollView.addSubview(positionLabel)
        positionLabel.textColor = .black
        positionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(150)
        }
    }
    
    func setupTeamNameLabel() {
        scrollView.addSubview(nameLabel)
        nameLabel.textColor = .black
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(positionLabel.snp_trailingMargin).offset(10)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(550)
        }
    }
    
    func setupLabelsText(teamInfo: TeamStatsModel) {
        positionLabel.text = teamInfo.position
        nameLabel.text = teamInfo.name
    }
    
    func setupCell(teamInfo: TeamStatsModel) {
        setupScrollView()
        setupTeamPositionLabel()
        setupTeamNameLabel()
        
        setupLabelsText(teamInfo: teamInfo)
    }
    
}
