//
//  MainTabBarFactory.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import UIKit

struct MainTabBarFactory {
    let appDIContainer: AppDIContainer?
    
    func makeMainTabBarController() -> UITabBarController {
        MainTabBarController()
    }
    
    func makeChildCoordinators(delegate: SettingsCoordinatorDelegate) -> [Coordinator] {
        [
            makeHomeCoordinator(),
            makeSettingsCoordinator(delegate: delegate)
        ]
    }
    
    private func makeHomeCoordinator() -> Coordinator {
        let factory = CharactersFactoryImp()
        let router = RouterImp(rootViewController: UINavigationController.init())
        return CharactersCoordinator(router: router, factory: factory)
    }
    
    private func makeSettingsCoordinator(delegate: SettingsCoordinatorDelegate) -> Coordinator {
        let factory = SettingsFactory(appDIContainer: appDIContainer)
        let router = RouterImp(rootViewController: UINavigationController.init())
        return SettingsCoordinator(
            router: router,
            factory: factory,
            delegate: delegate
        )
    }
}
