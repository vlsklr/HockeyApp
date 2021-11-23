//
//  GamesViewController.swift
//  HockeyApp
//
//  Created by Vlad on 20.11.2021.
//

import UIKit
import SnapKit

class GamesViewController: UIViewController {
    
    let tableView: UITableView = UITableView()
    private let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
//    private let presenter: IFavoriteFlyghtListPresenter
    private let refreshControll: UIRefreshControl = {
        let refresh = UIRefreshControl()
//        refresh.addTarget(self, action: #selector(refreshFlyghts(sender:)), for: .valueChanged)
        return refresh
    }()
    
    
    init() {
//        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = .systemBlue
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        tableView.refreshControl = refreshControll
        initActivityIndicator()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initTableView()
        tableView.reloadData()
    }
    
    func initTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GameCell.self, forCellReuseIdentifier: "cell")
//        tableView.layer.cornerRadius = 25
        tableView.backgroundColor = .white
        tableView.snp.makeConstraints { constraint in
            constraint.top.equalToSuperview().offset(50)
            constraint.leading.equalToSuperview()
            constraint.trailing.equalToSuperview()
            let tabBarHeight = -1 * (tabBarController?.tabBar.bounds.height ?? 50)
            constraint.bottom.equalToSuperview().offset(tabBarHeight)
        }
    }
    
    func initActivityIndicator() {
        tableView.addSubview(activityIndicator)
        activityIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
        activityIndicator.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(250)
        }
    }
}

extension GamesViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .destructive, title: RootViewController.labels?.deleteFlyghtButton) { _, _, complete in
//            let cell = tableView.cellForRow(at: indexPath) as! FlyghtViewCell
//            if let flyghtID = cell.entityID {
//                self.presenter.removeFlyght(flyghtID: flyghtID)
//                tableView.reloadData()
//            }
//            complete(true)
//        }
//
//        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
//        configuration.performsFirstActionWithFullSwipe = true
//        return configuration
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath)
//        cell?.backgroundColor = .green
   
//        let cell = tableView.cellForRow(at: indexPath) as! FlyghtViewCell
//        if let entityID = cell.entityID {
//            presenter.getFavorite(flyghtID: entityID)
//
//        }
    }
    
    
}
extension GamesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.00
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return presenter.getFlyghtsCount()
        return 15
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = GameCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GameCell
        cell.setupCell()
//        cell.backgroundColor = .magenta
//        cell.backgroundColor = UIColor.clear
        
//        if let getter:[FlyghtViewModel] = presenter.getFlyghts() {
//            if indexPath.row < getter.count {
//                cell.setupCell(id: getter[indexPath.row].flyghtID)
//                cell.flyghtNumberLabel.text = "\(RootViewController.labels!.favoriteCellFlyghtNumber)  \(getter[indexPath.row].flyghtNumber)"
//                cell.departireTimeLabel.text = "\(RootViewController.labels!.favoriteCellDepartureDate)  \(getter[indexPath.row].departureDateLocal)"
//            }
//        }
        return cell
    }
}
