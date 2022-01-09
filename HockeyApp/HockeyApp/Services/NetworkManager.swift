//
//  NetworkManager.swift
//  HockeyApp
//
//  Created by Admin on 25.11.2021.
//

import Foundation
import SwiftSoup

protocol INetworkManager {
    func loadGames(url: String, completion: @escaping ( _ games: [GameModel]) -> ())
    func loadInfo(url: String, completion: @escaping (Result<Data, Error>) -> Void)
    func loadGameInfo(url: String, game: GameModel, completion: @escaping ( _ game: GameModel) -> ())
    func loadTables(_ urlString: String, completion: @escaping( _ teamsStats: [TeamStatsModel]) -> ())
}

class NetworkManager: INetworkManager {
    
    func loadInfo(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 15
        let session = URLSession.shared
        session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let data = data else {
                    return
                }
                completion(.success(data))
            }
        }).resume()
    }
    
    func loadGameInfo(url: String,  game: GameModel, completion: @escaping ( _ game: GameModel) -> ()) {
        guard let matchLink = game.matchLink else {return}
        var game = game
        let urlString = url + matchLink
        loadInfo(url: urlString) { result in
            switch result {
            case .success(let data):
                var eventsList = [EventModel]()
                guard let stringData = String(data: data, encoding: .utf8) else { return }
                let gameData = try? SwiftSoup.parse(stringData)
                guard let fullNameTeams = try? gameData?.getElementsByClass("url__r"), let events = try? gameData?.getElementsByClass("events__col-bg"), let eventsTime = try? gameData?.getElementsByClass("events__col") else { return }
                var index = 0
                for element in events {
                    if let iconPath = try? element.getElementsByClass("img-fluid").attr("src"),
                       iconPath.contains("goal"),
                       let names = try? element.getElementsByClass("events__name"),
                       let timeDescription = try? eventsTime.get(index),
                       let time = try? timeDescription.getElementsByClass("events__time").text(),
                       let description = try? timeDescription.getElementsByClass("line-up").text() {
                        //если иконка имеет класс right, то событие относится к гостевой команде
                        let eventTeam = try? element.getElementsByClass("events__icon").hasClass("right")
                        var persons = [PersonModel]()
                        for name in names {
                            if let nameText = try? name.text() {
                                let person = PersonModel(name: nameText)
                                persons.append(person)
                            }
                        }
                        let event = EventModel(type: .goal, description: description, isHomeTeamEvent: eventTeam ?? false, players: persons, time: time)
                        eventsList.append(event)
                        index += 1
                    } else if let iconPath = try? element.getElementsByClass("img-fluid").attr("src"), iconPath.contains("ejection"), let description = try? element.getElementsByClass("events__name").last()?.text(),
                              let name = try? element.getElementsByClass("events__name").first()?.text(),
                              let timeDescription = try? eventsTime.get(index),
                              let time = try? timeDescription.getElementsByClass("events__time").text() {
                        var persons = [PersonModel]()
                        persons.append(PersonModel(name: name))
                        let eventTeam = try? element.getElementsByClass("events__icon").hasClass("right")
                        let event = EventModel(type: .ejection, description: description, isHomeTeamEvent: eventTeam ?? false, players: persons, time: time)
                        eventsList.append(event)
                        index += 1
                    }
                }
                game.homeTeam.name = try? fullNameTeams[0].text()
                game.visitorTeam.name = try? fullNameTeams[2].text()
                game.cupName = try? fullNameTeams[1].text()
                game.events = eventsList
                completion(game)
            case .failure(let error):
                print (error)
            }
        }
    }
    
    func loadGames(url: String, completion: @escaping ( _ games: [GameModel]) -> ()) {
        var matches: [GameModel] = [GameModel]()
        loadInfo(url: url) { result in
            switch result {
            case .success(let data):
                guard let siteString = String(data: data, encoding: .utf8) else { return }
                let document: Document? = try? SwiftSoup.parse(siteString)
                guard let gamesList = try? document?.getElementsByClass("slide__match-block") else {
                    print("something went wrong")
                    return
                }
                for game: Element in gamesList.array() {
                    guard let teams = try? game.getElementsByClass("slide__command"), let team1 = try? teams.first()?.getElementsByClass("slide__command-name").text(), let team2 = try? teams.last()?.getElementsByClass("slide__command-name").text(), let dateBlock = try? game.getElementsByClass("slide__date-block"), let date = try? game.getElementsByClass("slide__date").text(), let scoresRawValue = try? dateBlock.first()?.getElementsByTag("H4").text(), let arena = try? game.getElementsByClass("slide__match-link").first()?.text(), let homeTeamLogo = try? teams.first()?.getElementsByClass("img-fluid").attr("src"), let visitorTeamLogo = try? teams.last()?.getElementsByClass("img-fluid").attr("src"), let gameNumberLinkElement = try? game.getElementsByClass("slide__match-info").attr("onclick") else {return}
                    
                    var gameNumberString: String? = nil
                    var visitorScores: Int?
                    var homeScores: Int?
                    if let index = gameNumberLinkElement.firstIndex(of: "/") {
                        gameNumberString = String(gameNumberLinkElement[index...]).trimmingCharacters(in: .init(charactersIn: "'\\"))
                        
                    }
                    let homeTeamLogoAddress = url + homeTeamLogo.replacingOccurrences(of: "\\", with: "/")
                    let visitorTeamAddres = url + visitorTeamLogo.replacingOccurrences(of: "\\", with: "/")
                    let separatedScores = scoresRawValue.split(separator: ":", maxSplits: 2, omittingEmptySubsequences: true)
                    if separatedScores.count == 2 {
                        homeScores = Int(separatedScores[0].trimmingCharacters(in: .whitespacesAndNewlines))
                        visitorScores = Int(separatedScores[1].trimmingCharacters(in: .whitespacesAndNewlines))
                    }
                    var homeTeam = TeamModel(name: nil, shortName: team1)
                    var visitorTeam = TeamModel(name: nil, shortName: team2)
                    homeTeam.logoLink = homeTeamLogoAddress
                    visitorTeam.logoLink = visitorTeamAddres
                    let game = GameModel(visitorTeam: visitorTeam, homeTeam: homeTeam, visitorScores: visitorScores, homeScores: homeScores, gamedate: date, arena: arena, matchLink: gameNumberString, cupName: nil)
                    matches.append(game)
                }
                completion(matches)
            case .failure(let error):
                print(error)
            }
        }
    }
    func loadTables(_ urlString: String, completion: @escaping( _ teamsStats: [TeamStatsModel]) -> ()) {
        loadInfo(url: urlString) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                guard let siteString = String(data: data, encoding: .utf8) else { return }
                let document: Document? = try? SwiftSoup.parse(siteString)
                var table = [TeamStatsModel]()
                guard let teams = try? document?.getElementsByTag("tr") else { return }
                for index in 1...teams.count - 1 {
                    guard let team = try? teams.get(index),
                          let teamStats = try? team.getElementsByTag("td"), let teamInfo = try? TeamStatsModel(name: teamStats.get(1).text(), position: teamStats.get(0).text(), games: teamStats.get(2).text(), wins: teamStats.get(3).text(), overtimeWins: teamStats.get(4).text(), shoutoutWins: teamStats.get(5).text(), overtimeLoses: teamStats.get(6).text(), shoutoutLoses: teamStats.get(7).text(), loses: teamStats.get(8).text(), goals: teamStats.get(9).text(), points: teamStats.get(10).text()) else { return }
                    table.append(teamInfo)
//                    table.append(team)
                    // po teams.get(1).getElementsByTag("td").get(1).text()
//                    "Кубометр"
                }
                completion(table)
            }
        }
    }
}
