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
        controller.title = "Настройки"
        return controller
    }
    
    func makeChangePasswordController() -> UIViewController {
        let controller = ChangePassViewController(user: appDIContainer.auth.user, keychain: appDIContainer.keychain)
        return controller
    }
        
    func makeTabBarItem(router: Router) {
        makeItemTabBar(router: router,
                       title: "Настройки",
                       image: "gearshape.2",
                       selectedImage: "gearshape.2.fill")
    }
}
