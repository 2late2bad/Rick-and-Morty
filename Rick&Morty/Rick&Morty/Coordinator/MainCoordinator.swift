//
//  MainCoordinator.swift
//  Rick&Morty
//
//  Created by Alexander V. on 23.10.2023.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    var rootViewController: UITabBarController
    
    init() {
        rootViewController = BaseTabBarController()
        rootViewController.tabBar.isTranslucent = true
        rootViewController.tabBar.backgroundColor = .lightGray
    }
    
    func start() {
        let characterCoordinator = CharacterTabCoordinator()
        characterCoordinator.start()
        let characterViewController = characterCoordinator.rootViewController
        setup(
            vc: characterViewController,
            title: "Персонажи",
            imageName: "person.text.rectangle",
            selectedImageName: "person.text.rectangle.fill"
        )
        
        let logoutCoordinator = LogoutTabCoordinator()
        logoutCoordinator.start()
        let logoutViewController = logoutCoordinator.rootViewController
        setup(
            vc: logoutViewController,
            title: "Выход",
            imageName: "arrow.uturn.left.square",
            selectedImageName: "arrow.uturn.left.square.fill"
        )
    
        self.rootViewController.viewControllers = [characterViewController, logoutViewController]
    }
    
    private func setup(vc: UIViewController, title: String, imageName: String, selectedImageName: String) {
        let nonSelectedImage = UIImage(systemName: imageName)
        let selectedImage = UIImage(systemName: selectedImageName)
        let tabBarItem = UITabBarItem(title: title, image: nonSelectedImage, selectedImage: selectedImage)
        vc.tabBarItem = tabBarItem
    }
}
