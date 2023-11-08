//
//  Resources.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import UIKit

typealias R = Resources

enum Resources {
    
    enum ViewValues {
        // Common
        static let widthScreen = UIScreen.main.bounds.width
        static let doublePadding: CGFloat = 20
        // For Cells
        static let defaultHeightContainerCell: CGFloat = 100
        static let defaultCornerRadius: CGFloat = 10
    }
    
    enum Images {
        static let defaultImage = "default"
    }
}
