//
//  UIView+ext.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import UIKit.UIView

extension UIView {
    
    func setConstraints(
        top: NSLayoutYAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        pTop: CGFloat = CGFloat.zero,
        pRight: CGFloat = CGFloat.zero,
        pBottom: CGFloat = CGFloat.zero,
        pLeft: CGFloat = CGFloat.zero
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top {
            topAnchor.constraint(equalTo: top, constant: pTop).isActive = true
        }
        
        if let right {
            rightAnchor.constraint(equalTo: right, constant: -pRight).isActive = true
        }
        
        if let bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -pBottom).isActive = true
        }
        
        if let left {
            leftAnchor.constraint(equalTo: left, constant: pLeft).isActive = true
        }
    }
    
    func setHeightConstraint(with height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setWidthConstraint(with width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
}