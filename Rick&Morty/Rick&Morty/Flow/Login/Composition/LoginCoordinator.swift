//
//  LoginCoordinator.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import UIKit

protocol LoginCoordinatorDelegate: AnyObject {
    func didFinishLogin()
}

final class LoginCoordinator: Coordinator {
    
    var router: Router
    var factory: LoginFactory
    weak var delegate: LoginCoordinatorDelegate?
    
    init(
        router: Router,
        factory: LoginFactory,
        delegate: LoginCoordinatorDelegate
    ) {
        self.router = router
        self.factory = factory
        self.delegate = delegate
    }
    
    func start() {
        let controller = factory.makeLoginViewController(coordinator: self)
        router.pushViewController(controller, animated: true)
    }
}

extension LoginCoordinator: LoginViewControllerCoordinator {
    func didFinish() {
        delegate?.didFinishLogin()
    }
}
