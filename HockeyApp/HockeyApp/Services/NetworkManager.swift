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
        loadInfo(url: url + matchLink) { result in
            switch result {
            case .success(let data):
                guard let stringData = String(data: data, encoding: .utf8) else { return }
                let gameData = try? SwiftSoup.parse(stringData)
                print(gameData)
//                completion(data)
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
                        gameNumberString = String(gameNumberLinkElement[index...])
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
                    let game = GameModel(visitorTeam: visitorTeam, homeTeam: homeTeam, visitorScores: visitorScores, homeScores: homeScores, gamedate: date, arena: arena, matchLink: gameNumberString)
                    matches.append(game)
                }
                completion(matches)
            case .failure(let error):
                print(error)
            }
        }
    }
}
