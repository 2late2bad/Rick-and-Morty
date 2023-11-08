//
//  SettingCoordinator.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import UIKit

protocol SettingsCoordinatorDelegate: AnyObject {
    func didTapLogout()
}

final class SettingsCoordinator: Coordinator {
    
    var router: Router
    private var factory: SettingsFactory
    private weak var delegate: SettingsCoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    
    init(
        router: Router,
        factory: SettingsFactory,
        delegate: SettingsCoordinatorDelegate
    ) {
        self.router = router
        self.factory = factory
        self.delegate = delegate
    }
    
    func start() {
        let controller = factory.makeSettingsController(coordinator: self)
        router.navigationBar.prefersLargeTitles = true
        router.pushViewController(controller, animated: true)
        factory.makeTabBarItem(router: router)
    }
}

extension SettingsCoordinator: ParentCoordinator {}

extension SettingsCoordinator: SettingsViewControllerCoordinator {
    
    func didSelectCell(settingsViewNavigation: SettingsViewNavigation) {
        switch settingsViewNavigation {
        case .changePassword:
            // router.pushViewController(factory.makeChangePassViewController(), animated: true)
            break
        case .logout:
            delegate?.didTapLogout()
        }
    }
    
    private func callUserConfigurationCoordinator() {
//        let userConfigurationCoordinator = factory.makeUserConfigurationCoordinator(delegate: self)
//        addChild(userConfigurationCoordinator)
//
//        router.present(userConfigurationCoordinator.navigation.rootViewController, animated: true)
//        // Если открываем модально, а не на фулл экран:
//        userConfigurationCoordinator.navigation.dismissNavigation = { [weak self] in
//            self?.removeChild(userConfigurationCoordinator)
//        }
    }
}

//extension SettingsCoordinator: UserConfigurationCoordinatorDelegate {
//    func didFinish(childCoordinator: Coordinator) {
//        // Если открываем на фулл экран:
//        childCoordinator.router.dismissNavigation = nil
//        removeChild(childCoordinator)
//        router.dismiss(animated: true)
//    }
//}
