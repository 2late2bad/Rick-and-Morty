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
        static let opacityContainerSpinner = 0.3
        static let tagIdentifierSpinner = 123
        static let doublePadding: CGFloat = 20
        static let normalPadding: CGFloat = 10
        // For Cells
        static let defaultHeightCell = 44
        static let defaultHeightContainerCell: CGFloat = 110
        static let defaultCornerRadius: CGFloat = 10
    }
    
    enum Images {
        static let defaultImage = "default"
    }
}
