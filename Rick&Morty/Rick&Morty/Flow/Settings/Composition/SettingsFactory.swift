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
        controller.title = R.Name.settingsTitleVC
        return controller
    }
    
    func makeChangePasswordController() -> UIViewController {
        let controller = ChangePassViewController(user: appDIContainer.auth.user, keychain: appDIContainer.keychain)
        return controller
    }
        
    func makeTabBarItem(router: Router) {
        makeItemTabBar(router: router,
                       title: R.Name.settingsTitleVC,
                       image: R.Images.settingsTabBarDefault,
                       selectedImage: R.Images.settingsTabBarSelected)
    }
}
