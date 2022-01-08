//
//  TablesCell.swift
//  HockeyApp
//
//  Created by Admin on 05.01.2022.
//

import Foundation
import UIKit
import SnapKit

protocol ITablesCell: AnyObject {
    func setNumberOfRow(number: Int)
    func setupCell(teamsInfo: [TeamStatsModel], numberOfRow: Int)
}

class TablesCell: UICollectionViewCell, ITablesCell {
    var tableView = UITableView()
    var data: [TeamStatsModel]?
    var numberOfRow: Int?
//    override func prepareForReuse() {
//        super.prepareForReuse()
//    }
    
    func setupTableView() {
        contentView.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
        }
    }
    
    func setupTextLabel(text: String, index: Int) {
        let textLabel = UILabel()
        contentView.addSubview(textLabel)
        textLabel.textColor = .black
        textLabel.textAlignment = .center
        textLabel.text = text
        textLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(5 + 50 * index)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(25)
        }
    }
    func setNumberOfRow(number: Int) {
        if numberOfRow == nil {
            numberOfRow = number
        }
    }
    
    func setupCell(teamsInfo: [TeamStatsModel], numberOfRow: Int) {
        data = teamsInfo
        setNumberOfRow(number: numberOfRow)
        setupTableView()
//        for index in 0...teamsInfo.count - 1 {
//            switch numberOfRow {
//            case 0 :
//                setupTextLabel(text: teamsInfo[index].position, index: index)
//            case 1:
//                setupTextLabel(text: teamsInfo[index].name, index: index)
//            case 2:
//                setupTextLabel(text: teamsInfo[index].games, index: index)
//            case 3:
//                setupTextLabel(text: teamsInfo[index].wins, index: index)
//            case 4:
//                setupTextLabel(text: teamsInfo[index].overtimeWins, index: index)
//            case 5:
//                setupTextLabel(text: teamsInfo[index].shoutoutWins, index: index)
//            case 6:
//                setupTextLabel(text: teamsInfo[index].overtimeLoses, index: index)
//            case 7:
//                setupTextLabel(text: teamsInfo[index].shoutoutLoses, index: index)
//            case 8:
//                setupTextLabel(text: teamsInfo[index].loses, index: index)
//            case 9:
//                setupTextLabel(text: teamsInfo[index].points, index: index)
//            default:
//                print("tmp")
//            }
//        }
    }
    
}

extension TablesCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .green
        cell.selectionStyle = .none
        var text = ""
        switch self.numberOfRow {
        case 0 :
            text = data?[indexPath.row].position ?? ""
        case 1:
            text = data?[indexPath.row].name ?? ""
        case 2:
            text = data?[indexPath.row].games ?? ""
        case 3:
            text = data?[indexPath.row].wins ?? ""
        case 4:
            text = data?[indexPath.row].overtimeWins ?? ""
        case 5:
            text = data?[indexPath.row].shoutoutWins ?? ""
        case 6:
            text = data?[indexPath.row].overtimeLoses ?? ""
        case 7:
            text = data?[indexPath.row].shoutoutLoses ?? ""
        case 8:
            text = data?[indexPath.row].loses ?? ""
        case 9:
            text = data?[indexPath.row].points ?? ""
        default:
            print("tmp")
        }
        cell.textLabel?.text = text
        return cell
    }


}


