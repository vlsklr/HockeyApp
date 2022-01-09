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
    func setupCell(teamsInfo: [TeamStatsModel], numberOfRow: Int)
}

class TablesCell: UICollectionViewCell, ITablesCell {
    var index: Int?
    var tableView = UITableView()
    var data: [TeamStatsModel]?
 


    
    func setupTableView() {
        contentView.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
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
    
    func setupCell(teamsInfo: [TeamStatsModel], numberOfRow: Int) {
        data = teamsInfo
        index = numberOfRow
        setupTableView()
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
        switch self.index {
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
            text = data?[indexPath.row].goals ?? ""
        case 10:
            text = data?[indexPath.row].points ?? ""
        default:
            print("tmp")
        }
        cell.textLabel?.text = text
        return cell
    }


}


