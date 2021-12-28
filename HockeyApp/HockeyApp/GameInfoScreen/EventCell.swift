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
    let eventDescription = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupDescription() {
        contentView.addSubview(eventDescription)
        backgroundColor = .white
        selectionStyle = .none
        eventDescription.textColor = .black
        eventDescription.numberOfLines = 0
        eventDescription.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
    }
    
    func setupCell(event: EventModel) {
        setupDescription()
        var descriptionString = ""
        for name in event.players {
            descriptionString += "\(name.name)\n"
        }
        eventDescription.text = descriptionString
        if event.isHomeTeamEvent {
            eventDescription.textAlignment = .right
        }
    }
}
