//
//  NetworkManager.swift
//  HockeyApp
//
//  Created by Admin on 25.11.2021.
//

import Foundation
import SwiftSoup


class NetworkManager {
    
    func loadInfo(url: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "https://sibhl.ru/") else { return }
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
    
    func loadGames(url: String) -> [GameModel] {
        var matches: [GameModel] = [GameModel]()
        loadInfo(url: url) { result in
            switch result {
            case .success(let rawData):
                let document: Document? = try? SwiftSoup.parse(rawData)
                guard let gamesList = try? document?.getElementsByClass("slide__match-info") else {
                    print("something went wrong")
                    return
                }
                for game: Element in gamesList.array() {
                    guard let teams = try? game.getElementsByClass("slide__command"), let team1 = try? teams.first()?.getElementsByClass("slide__command-name").text(), let team2 = try? teams.last()?.getElementsByClass("slide__command-name").text()  else {return}
                    let homeTeam = TeamModel(name: nil, shortName: team1)
                    let visitorTeam = TeamModel(name: nil, shortName: team2)
                    let game = GameModel(visitorTeam: visitorTeam, homeTeam: homeTeam, visitorScores: 0, homeScores: 0, gamedate: "1234")
                    matches.append(game)

                }
            case .failure(let error):
                print(error)
            }
        }
        return matches
    }
}
