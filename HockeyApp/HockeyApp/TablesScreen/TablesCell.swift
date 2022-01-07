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
        
        for index in 0...teamsInfo.count - 1 {
            switch numberOfRow {
            case 0 :
                setupTextLabel(text: teamsInfo[index].position, index: index)
            case 1:
                setupTextLabel(text: teamsInfo[index].name, index: index)
            case 2:
                setupTextLabel(text: teamsInfo[index].games, index: index)
            case 3:
                setupTextLabel(text: teamsInfo[index].wins, index: index)
            case 4:
                setupTextLabel(text: teamsInfo[index].overtimeWins, index: index)
            case 5:
                setupTextLabel(text: teamsInfo[index].shoutoutWins, index: index)
            case 6:
                setupTextLabel(text: teamsInfo[index].overtimeLoses, index: index)
            case 7:
                setupTextLabel(text: teamsInfo[index].shoutoutLoses, index: index)
            case 8:
                setupTextLabel(text: teamsInfo[index].loses, index: index)
            case 9:
                setupTextLabel(text: teamsInfo[index].points, index: index)
            default:
                print("tmp")
            }
        }
    }
    
}


