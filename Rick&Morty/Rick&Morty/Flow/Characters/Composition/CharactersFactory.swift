//
//  CharactersFactory.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import UIKit

protocol CharactersFactory {
    func makeCharactersViewController(coordinator: CharactersViewControllerCoordinator) -> UIViewController
    func makeItemTabBar(router: Router)
//    func makePostDetailCoordinator(router: Router, id: Int, parentCoordinator: ParentCoordinator) -> Coordinator
}

struct CharactersFactoryImp: CharactersFactory {
    
    func makeCharactersViewController(coordinator: CharactersViewControllerCoordinator) -> UIViewController {
        let controller = CharactersViewController()
        controller.navigationItem.title = "Персонажи"
        return controller
    }
    
    func makeItemTabBar(router: Router) {
        makeItemTabBar(
            router: router,
            title: "Персонажи",
            image: "person.text.rectangle",
            selectedImage: "person.text.rectangle.fill"
        )
    }
    
//    func makeCharacterDetailCoordinator(router: Router, id: Int, parentCoordinator: ParentCoordinator) -> Coordinator {
//        let factory = CharacterDetailFactory(id: id)
//        let coordinator = CharacterDetailCoordinator(router: router,
//                                                factory: factory,
//                                                parentCoordinator: parentCoordinator)
//        return coordinator
//    }
}

extension CharactersFactoryImp: ItemTabBarFactory {}
