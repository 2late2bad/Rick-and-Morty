//
//  UIImageView+ext.swift
//  Rick&Morty
//
//  Created by Alexander V. on 09.11.2023.
//

import UIKit.UIImageView

extension UIImageView {
    func setImageFromData(data: Data?) {
        if let data, let image = UIImage(data: data) {
            self.image = image
        }
    }
    
    func addDefaultImage() {
        image = UIImage(named: R.Images.defaultImage)
    }
}
