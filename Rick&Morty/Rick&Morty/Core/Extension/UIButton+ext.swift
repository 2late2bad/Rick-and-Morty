//
//  UIButton+ext.swift
//  Rick&Morty
//
//  Created by Alexander V. on 12.11.2023.
//

import UIKit.UIButton

extension UIButton {
    
    func setTitleKeepingFont(_ title: String?) {
        guard
            configuration != nil,
            let title,
            let currentFont = titleLabel?.font
        else {
            setTitle(title, for: .normal)
            return
        }
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: currentFont
        ]
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        setAttributedTitle(attributedTitle, for: .normal)
    }
}
