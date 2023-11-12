//
//  LoginFactory.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import UIKit

struct LoginFactory {
    
    let appDIContainer: AppContainer
    
    func makeLoginViewController(coordinator: LoginViewControllerCoordinator) -> UIViewController {
        LoginViewController(
            coordinator: coordinator,
            viewModel: LoginViewModel(loginAuth: appDIContainer.auth)
        )
    }
}
