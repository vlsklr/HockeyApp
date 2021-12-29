//
//  EventCell.swift
//  HockeyApp
//
//  Created by Admin on 26.12.2021.
//

import Foundation
import UIKit
import SnapKit

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
    
    func setPlayers(isHomeEvent: Bool) {
        contentView.addSubview(players)
        backgroundColor = .white
        selectionStyle = .none
        eventDescription.textColor = .black
        eventDescription.numberOfLines = 0
    }
    
    func setupDescription(isHomeEvent: Bool) {
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
//            make.leading.equalToSuperview().offset(isHomeEvent ? 10 : 100)
//            make.trailing.equalToSuperview().offset(isHomeEvent ? -100 : -10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func setupEventIcon(isHomeEvent: Bool, eventType: EventType) {
        contentView.addSubview(eventIcon)
        let isGoalEvent = eventType == EventType.goal
        eventIcon.image = UIImage(named: isGoalEvent ? "goal.svg" : "ejection.svg")
        eventIcon.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView)
//            make.top.equalToSuperview().offset(10)
//            make.bottom.equalToSuperview().offset(-10)
            if isHomeEvent {
                make.leading.equalToSuperview().offset(10)
            } else {
                make.trailing.equalToSuperview().offset(-10)
            }
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
    }
    
    func setupCell(event: EventModel) {
        setupDescription(isHomeEvent: event.isHomeTeamEvent)
        var players = ""
        for name in event.players {
            players += "\(name.name)\n"
        }
        
        eventDescription.text = event.time + "\n \(event.description)"
//        if event.isHomeTeamEvent {
//            eventDescription.textAlignment = .right
//        } else {
//            eventDescription.textAlignment = .left
//        }
        
        setupEventIcon(isHomeEvent: event.isHomeTeamEvent, eventType: event.type)
        
    }
}
