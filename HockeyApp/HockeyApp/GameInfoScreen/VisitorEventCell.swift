//
//  VisitorEventCell.swift
//  HockeyApp
//
//  Created by Vlad on 03.01.2022.
//

import Foundation
import UIKit
import SnapKit

class VisitorEventCell: EventCell {
    func setupEventIconContraints() {
        eventIcon.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView)
            make.leading.equalToSuperview().offset(((cellWidth ?? 0) * 0.35) / 2 - 15)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
    }
    
    func setupEventPlayersConstraints() {
        players.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView)
            make.trailing.equalToSuperview().offset(-15)
            make.leading.equalTo(eventDescription.snp_trailingMargin).offset(15)
        }
    }
}

extension VisitorEventCell: IEventCell {
    func setupCell(event: EventModel) {
        setupDescription()
        var playersText = ""
        for name in event.players {
            playersText += "\(name.name)\n"
        }
        setPlayers()
        setupEventPlayersConstraints()
        players.text = playersText
        eventDescription.text = event.time + "\n \(event.description)"
        setupEventIcon(eventType: event.type)
        setupEventIconContraints()
    }
    
}
