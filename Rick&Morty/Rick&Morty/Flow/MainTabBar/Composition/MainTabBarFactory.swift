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
            makeCharactersCoordinator(),
            makeSettingsCoordinator(delegate: delegate)
        ]
    }
    
    private func makeCharactersCoordinator() -> Coordinator {
        let factory = CharactersFactoryImp(urlList: Endpoint.charURL)
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
