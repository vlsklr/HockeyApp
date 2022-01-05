//
//  TablesViewController.swift
//  HockeyApp
//
//  Created by Vlad on 20.11.2021.
//

import Foundation
import UIKit

protocol ITablesViewController: AnyObject {
    
}

class TablesViewController: UIViewController, ITablesViewController {
    
    let presenter: ITablesPresenter
    let tableView = UITableView()
    
    init(presenter: ITablesPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = .green
//        self.navigationController?.navigationBar.backgroundColor = .systemBlue
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TablesCell.self, forCellReuseIdentifier: "teamCell")
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.top.equalToSuperview().offset(25)
            make.bottom.equalToSuperview().offset(-50)
        }
    }
}

extension TablesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getTeamsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell") as! TablesCell
        presenter.setupCell(teamCell: cell, for: indexPath.row)
        return cell
    }
}
