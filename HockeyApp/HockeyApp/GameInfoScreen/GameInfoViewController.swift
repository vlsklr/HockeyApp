//
//  GameInfoViewController.swift
//  HockeyApp
//
//  Created by Admin on 15.12.2021.
//

import Foundation
import UIKit


class GameInfoViewController: UIViewController {
        
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = .green
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
