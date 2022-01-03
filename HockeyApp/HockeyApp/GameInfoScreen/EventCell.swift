//
//  EventCell.swift
//  HockeyApp
//
//  Created by Admin on 26.12.2021.
//

import Foundation
import UIKit
import SnapKit

protocol IEventCell {
    func setupCell(event: EventModel)
}

class EventCell: UITableViewCell {
    let players = UILabel()
    let eventDescription = UILabel()
    let eventIcon = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setPlayers() {
        contentView.addSubview(players)
        backgroundColor = .white
        selectionStyle = .none
        players.textColor = .black
        players.numberOfLines = 0
    }
    
    func setupDescription() {
        contentView.addSubview(eventDescription)
        backgroundColor = .white
        selectionStyle = .none
        eventDescription.textAlignment = .center
        eventDescription.textColor = .black
        eventDescription.numberOfLines = 0
        eventDescription.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalTo(self.contentView)
            make.width.equalTo(self.contentView.bounds.width * 0.3)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func setupEventIcon(eventType: EventType) {
        contentView.addSubview(eventIcon)
        let isGoalEvent = eventType == EventType.goal
        eventIcon.image = UIImage(named: isGoalEvent ? "goal" : "ejection")
    }
}

