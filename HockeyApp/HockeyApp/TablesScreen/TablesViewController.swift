//
//  TablesViewController.swift
//  HockeyApp
//
//  Created by Vlad on 20.11.2021.
//

import Foundation
import UIKit


class TablesViewController: UIViewController {
    
    init() {
//        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        self.navigationController?.navigationBar.backgroundColor = .systemBlue
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
