//
//  EventModel.swift
//  HockeyApp
//
//  Created by Admin on 25.12.2021.
//

import Foundation

enum EventType {
    case ejection
    case goal
}

struct EventModel {
    let type: EventType
    let description: String
    let isHomeTeamEvent: Bool
    let players: [PersonModel]
    let time: String
}
