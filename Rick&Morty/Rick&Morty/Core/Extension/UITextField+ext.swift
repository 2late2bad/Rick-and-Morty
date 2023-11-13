//
//  UITextField+ext.swift
//  Rick&Morty
//
//  Created by Alexander V. on 12.11.2023.
//

import UIKit.UITextField
import Combine

extension UITextField {

    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .map { $0.text ?? "" }
            .eraseToAnyPublisher()
    }
}
