//
//  AppFactory.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import UIKit

struct AppFactory {
    let appDIContainer: AppDIContainer?
    
    func makeLoginCoordinator(
        router: Router,
        delegate: LoginCoordinatorDelegate
    ) -> Coordinator {
        let loginFactory = LoginFactory(appDIContainer: appDIContainer)
        return LoginCoordinator(router: router, factory: loginFactory, delegate: delegate)
    }
    
    func makeTabBarCoordinator(
        router: Router,
        delegate: MainTabBarCoordinatorDelegate
    ) -> Coordinator {
        let factory = MainTabBarFactory(appDIContainer: appDIContainer)
        return MainTabBarCoordinator(router: router, factory: factory, delegate: delegate)
    }
}
