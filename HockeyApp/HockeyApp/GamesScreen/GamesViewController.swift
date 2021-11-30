//
//  GamesViewController.swift
//  HockeyApp
//
//  Created by Vlad on 20.11.2021.
//

import UIKit
import SnapKit

protocol IGamesViewController: AnyObject {
    
}

class GamesViewController: UIViewController, IGamesViewController {
    
    let tableView: UITableView = UITableView()
    private let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
//    private let presenter: IFavoriteFlyghtListPresenter
    private let refreshControll: UIRefreshControl = {
        let refresh = UIRefreshControl()
//        refresh.addTarget(self, action: #selector(refreshFlyghts(sender:)), for: .valueChanged)
        return refresh
    }()
    var games:[GameModel]?

    
    
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
        tableView.backgroundColor = .white
        tableView.refreshControl = refreshControll
        initActivityIndicator()
        let manager = NetworkManager().loadGames(url: "https://sibhl.ru") { [self] result in
            
            self.games = result
            DispatchQueue.main.async {
                tableView.reloadData()

            }
        }
        print(manager)
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
        let cell = tableView.cellForRow(at: indexPath)
        
        //        cell?.selectedBackgroundView?.backgroundColor = .green
        
   
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
        return games?.count ?? 0
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GameCell
        cell.setupCell()
        cell.backgroundColor = .white
        if !(games?.isEmpty ?? true) {
            cell.homeTeamNameLabel.text = games?[indexPath.row].homeTeam.shortName
            cell.visitorTeamNameLabel.text = games?[indexPath.row].visitorTeam.shortName
            }

        return cell
    }
}
