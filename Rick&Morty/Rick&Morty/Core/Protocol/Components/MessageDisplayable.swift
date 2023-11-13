//
//  MessageDisplayable.swift
//  Rick&Morty
//
//  Created by Alexander V. on 09.11.2023.
//

import UIKit

protocol MessageDisplayable { }

extension MessageDisplayable where Self: UIViewController {
    func presentAlert(message: String, title: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: AppLocalized.okButton, style: .default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
}
