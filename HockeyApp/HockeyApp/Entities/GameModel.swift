//
//  Game.swift
//  
//
//  Created by Admin on 25.11.2021.
//

import Foundation

struct GameModel {
    var visitorTeam: TeamModel
    var homeTeam: TeamModel
    var visitorScores: Int?
    var homeScores: Int?
    var scoresDescription: String?
    var gamedate: String
    var arena: String
    let matchLink: String?
    var cupName: String?
    var events: [EventModel]?
}
