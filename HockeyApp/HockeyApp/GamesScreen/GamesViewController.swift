//
//  GamesViewController.swift
//  HockeyApp
//
//  Created by Vlad on 20.11.2021.
//

import UIKit
import SnapKit

class GamesViewController: UIViewController {
    
    init() {
//        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        self.navigationController?.navigationBar.backgroundColor = .systemBlue
//        setupSearchbar()
//        setupSearchButton()
//        setupSwipeDown()
//        setupActivityIndicator()
//        if let airportImage = UIImage(named: "airport_bgc") {
//            self.view.backgroundColor = UIColor(patternImage: airportImage)
//        }
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

