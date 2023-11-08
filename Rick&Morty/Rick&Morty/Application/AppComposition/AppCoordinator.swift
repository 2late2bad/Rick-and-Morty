//
//  AppCoordinator.swift
//  Rick&Morty
//
//  Created by Alexander V. on 23.10.2023.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    var router: Router
    var childCoordinators: [Coordinator] = []
    var window: UIWindow?
    var factory: AppFactory?
    var auth: SessionCheckerAuth?
    
    init(router: Router, window: UIWindow?, factory: AppFactory?, auth: SessionCheckerAuth?) {
        self.router = router
        self.window = window
        self.factory = factory
        self.auth = auth
    }
    
    func start() {
        configWindow()
        startSomeCoordinator()
    }
    
    private func configWindow() {
        window?.rootViewController = router.rootViewController
        window?.makeKeyAndVisible()
    }
    
    private func startSomeCoordinator() {
        guard let auth else { return }
        //auth.isSessionActive ? startMainTabBarCoordinator() : startLoginCoordinator()
        startMainTabBarCoordinator()
    }
    
    private func startLoginCoordinator() {
        let loginCoordinator = factory?.makeLoginCoordinator(router: router, delegate: self)
        addChild(loginCoordinator)
    }
    
    private func startMainTabBarCoordinator() {
        let mainTabBarCoordinator = factory?.makeTabBarCoordinator(router: router, delegate: self)
        addChild(mainTabBarCoordinator)
    }
    
    // Helpers
    private func clearCoordinatorsAndStart() {
        router.viewControllers = []
        clearAllChilds()
        startSomeCoordinator()
    }
}

extension AppCoordinator: LoginCoordinatorDelegate, MainTabBarCoordinatorDelegate {
    func didFinishLogin() {
        clearCoordinatorsAndStart()
    }
    
    func didFinish() {
        clearCoordinatorsAndStart()
    }
}

extension AppCoordinator: ParentCoordinator {}
