//
//  CharactersCoordinator.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import UIKit

final class CharactersCoordinator: Coordinator {
    
    var router: Router
    var childCoordinators: [Coordinator]
    private let factory: CharactersFactory
    
    init(router: Router, factory: CharactersFactory) {
        childCoordinators = []
        self.router = router
        self.factory = factory
    }
    
    func start() {
        let controller = factory.makeCharactersViewController(coordinator: self)
        factory.makeItemTabBar(router: router)
        router.navigationBar.prefersLargeTitles = true
        router.pushViewController(controller, animated: true)
    }
}

extension CharactersCoordinator: CharactersViewControllerCoordinator {
    func didListEpisodesCharacter(episodes: [String]) {
        let characterDetailCoordinator = factory.makeCharacterDetailCoordinator(
            router: router,
            parent: self,
            episodes: episodes)
        addChild(characterDetailCoordinator)
    }
}

extension CharactersCoordinator: ParentCoordinator {}
