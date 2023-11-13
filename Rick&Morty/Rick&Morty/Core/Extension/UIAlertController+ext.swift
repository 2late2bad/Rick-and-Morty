//
//  UIAlertController+ext.swift
//  Rick&Morty
//
//  Created by Alexander V. on 13.11.2023.
//

import UIKit

extension UIAlertController {
    static func showSuccessAlert(title: String, message: String, presentingViewController: UIViewController, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { _ in
            completion?()
        }
        alert.addAction(action)
        presentingViewController.present(alert, animated: true, completion: nil)
    }
}
