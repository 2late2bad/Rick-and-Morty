//
//  AppCoordinator.swift
//  Rick&Morty
//
//  Created by Alexander V. on 23.10.2023.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let mainCoordinator = MainCoordinator()
        mainCoordinator.start()
        
        window.rootViewController = mainCoordinator.rootViewController
        window.makeKeyAndVisible()
    }
}
