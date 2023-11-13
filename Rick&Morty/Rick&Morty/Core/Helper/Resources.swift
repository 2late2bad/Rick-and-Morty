//
//  Resources.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import UIKit

typealias R = Resources

enum Resources {
    
    enum Name {
        static let charTitleVC = "Персонажи"
        static let charEpisodesTitleVC = "Эпизоды"
        static let settingsTitleVC = "Настройки"
    }
    
    enum ViewValues {
        // Common
        static let widthScreen = UIScreen.main.bounds.width
        static let opacityContainerSpinner = 0.3
        static let tagIdentifierSpinner = 123
        static let doublePadding: CGFloat = 20
        static let normalPadding: CGFloat = 10
        // For Cells
        static let defaultHeightCell = 44
        static let defaultHeightContainerCell: CGFloat = 100
        static let defaultCornerRadius: CGFloat = 10
    }
    
    enum Images {
        static let defaultImage = "default"
        
        // Tab Bar Items
        static let charItemTabBarDefault = "person.text.rectangle"
        static let charItemTabBarSelected = "person.text.rectangle.fill"
        static let settingsTabBarDefault = "gearshape.2"
        static let settingsTabBarSelected = "gearshape.2.fill"
        
        // Setting items
        static let settingChangePass = "keyboard.badge.eye"
        static let settingExit = "door.right.hand.open"
    }
    
    enum UDKeys {
        static let auth = "auth"
        static let loginUser = "login_user"
    }
}
