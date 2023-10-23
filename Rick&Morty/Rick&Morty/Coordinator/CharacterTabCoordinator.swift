//
//  CharacterTabCoordinator.swift
//  Rick&Morty
//
//  Created by Alexander V. on 23.10.2023.
//

import UIKit

final class CharacterTabCoordinator: Coordinator {
    
    var rootViewController: UINavigationController
    
    init() {
        rootViewController = UINavigationController()
    }
    
    func start() {
        rootViewController.setViewControllers([CharacterViewController()], animated: false)
    }
}
