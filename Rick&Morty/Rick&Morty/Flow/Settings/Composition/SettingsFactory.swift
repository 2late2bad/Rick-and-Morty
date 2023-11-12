//
//  SettingsFactory.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import UIKit

struct SettingsFactory: ItemTabBarFactory {
    
    let appDIContainer: AppContainer
    
    func makeSettingsController(coordinator: SettingsViewControllerCoordinator) -> UIViewController {
        let viewModel = SettingsViewModel(auth: appDIContainer.auth)
        let controller = SettingsViewController(viewModel: viewModel, coordinator: coordinator)
        controller.title = "Настройки ⚙"
        return controller
    }
    
    func makeTabBarItem(router: Router) {
        makeItemTabBar(router: router,
                       title: "Настройки",
                       image: "gearshape.2",
                       selectedImage: "gearshape.2.fill")
    }
    
//    func makeChangePassViewController() -> UIViewController {
//        let controller = ChangeController()
//        controller.title = "Смена пароля"
//        return controller
//    }
//    
//    func makeUserConfigurationCoordinator(delegate: UserConfigurationCoordinatorDelegate) -> Coordinator {
//        let factory = UserConfigurationFactory()
//        // ---
//        let navController = UINavigationController.init()
//        navController.modalPresentationStyle = .fullScreen
//        let router = RouterImp(rootViewController: navController)
//        // ---
//        return UserConfigurationCoordinator(router: router, factory: factory, delegate: delegate)
//    }
}
