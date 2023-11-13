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
            router.present(factory.makeChangePasswordController(), animated: true)
        case .logout:
            delegate?.didTapLogout()
        }
    }
}
