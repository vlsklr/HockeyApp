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
}

class NetworkManager: INetworkManager {
    
    private func loadInfo(url: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 15
        let session = URLSession.shared
        
        session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let data = data, let dataString = String(data: data, encoding: .utf8) else {
                    return
                }
                completion(.success(dataString))
            }
        }).resume()
    }
    
    func loadGames(url: String, completion: @escaping ( _ games: [GameModel]) -> ()) {
        var matches: [GameModel] = [GameModel]()
        loadInfo(url: url) { result in
            switch result {
            case .success(let rawData):
                let document: Document? = try? SwiftSoup.parse(rawData)
                guard let gamesList = try? document?.getElementsByClass("slide__match-block") else {
                    print("something went wrong")
                    return
                }
                for game: Element in gamesList.array() {
                    guard let teams = try? game.getElementsByClass("slide__command"), let team1 = try? teams.first()?.getElementsByClass("slide__command-name").text(), let team2 = try? teams.last()?.getElementsByClass("slide__command-name").text(), let dateBlock = try? game.getElementsByClass("slide__date-block"), let date = try? game.getElementsByClass("slide__date").text(), let scoresRawValue = try? dateBlock.first()?.getElementsByTag("H4").text(), let arena = try? game.getElementsByClass("slide__match-link").first()?.text() else {return}
                    var visitorScores: Int = 0
                    var homeScores: Int = 0
                    let separatedScores = scoresRawValue.split(separator: ":", maxSplits: 2, omittingEmptySubsequences: true)
                    if separatedScores.count == 2 {
                        visitorScores = Int(separatedScores[0].trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
                        homeScores = Int(separatedScores[1].trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
                    }
                    let homeTeam = TeamModel(name: nil, shortName: team1)
                    let visitorTeam = TeamModel(name: nil, shortName: team2)
                    let game = GameModel(visitorTeam: visitorTeam, homeTeam: homeTeam, visitorScores: visitorScores, homeScores: homeScores, gamedate: date, arena: arena)
                    matches.append(game)

                }
                completion(matches)
            case .failure(let error):
                print(error)
            }
        }
    }
}
