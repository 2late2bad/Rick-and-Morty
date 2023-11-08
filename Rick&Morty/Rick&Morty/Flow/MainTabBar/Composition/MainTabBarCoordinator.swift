//
//  MainTabBarCoordinator.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import UIKit

protocol MainTabBarCoordinatorDelegate: AnyObject {
    func didFinish()
}

final class MainTabBarCoordinator: Coordinator {
    
    var router: Router
    private let factory: MainTabBarFactory
    private weak var delegate: MainTabBarCoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    
    init(
        router: Router,
        factory: MainTabBarFactory,
        delegate: MainTabBarCoordinatorDelegate
    ) {
        self.router = router
        self.factory = factory
        self.delegate = delegate
    }
    
    func start() {
        let navigationTabBar = factory.makeMainTabBarController()
        router.pushViewController(navigationTabBar, animated: false)
        router.navigationBar.isHidden = true
        
        childCoordinators = factory.makeChildCoordinators(delegate: self)
        let childNavigation = childCoordinators.map { $0.router.rootViewController }
        childCoordinators.forEach { $0.start() }
        navigationTabBar.viewControllers = childNavigation
    }
}

extension MainTabBarCoordinator: SettingsCoordinatorDelegate {
    func didTapLogout() {
        childCoordinators = []
        delegate?.didFinish()
    }
}
