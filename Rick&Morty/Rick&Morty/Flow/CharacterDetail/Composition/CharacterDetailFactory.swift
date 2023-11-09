//
//  CharacterDetailFactory.swift
//  Rick&Morty
//
//  Created by Alexander V. on 09.11.2023.
//

import UIKit

protocol CharacterDetailFactory {
    func makeModule(coordinator: CharacterDetailViewControllerCoordinator) -> UIViewController
}

struct CharacterDetailFactoryImp: CharacterDetailFactory {
    
    let urlDetail: String
    let appDIContainer: AppContainer

    func makeModule(coordinator: CharacterDetailViewControllerCoordinator) -> UIViewController {
        let controller = CharacterDetailViewController()
        return controller
    }
}
