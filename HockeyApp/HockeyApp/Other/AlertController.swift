//
//  AlertController.swift
//  HockeyApp
//
//  Created by Admin on 17.01.2022.
//

import Foundation
import UIKit

protocol IAlertController: AnyObject {
    var view: UIViewController? { get set }
    func showAlert(text: String)
}

class AlertController: IAlertController {
    weak var view: UIViewController?
    func showAlert(text: String) {
        let alert = UIAlertController(title: Texts.error.rawValue, message: text, preferredStyle: .alert)
       alert.addAction(UIAlertAction(title: "ОК", style: .default))
        DispatchQueue.main.async {
            self.view?.present(alert, animated: true)
        }
    }
}
