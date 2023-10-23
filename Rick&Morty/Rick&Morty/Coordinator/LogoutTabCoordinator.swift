//
//  LogoutTabCoordinator.swift
//  Rick&Morty
//
//  Created by Alexander V. on 23.10.2023.
//

import UIKit

final class LogoutTabCoordinator: Coordinator {
    
    var rootViewController: UINavigationController
    
    init() {
        rootViewController = UINavigationController()
    }
    
    func start() {
        rootViewController.setViewControllers([LogoutViewController()], animated: false)
    }
}
