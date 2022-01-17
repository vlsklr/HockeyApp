//
//  AlertController.swift
//  HockeyApp
//
//  Created by Admin on 17.01.2022.
//

import Foundation
import UIKit

protocol IAlertController: AnyObject {
   static func showAlert(text: String, view: UIViewController)
}

class AlertController: IAlertController {
   static func showAlert(text: String, view: UIViewController) {
        let alert = UIAlertController(title: Texts.error.rawValue, message: text, preferredStyle: .alert)
       alert.addAction(UIAlertAction(title: "ОК", style: .default))
       view.present(alert, animated: true)
    }
}
