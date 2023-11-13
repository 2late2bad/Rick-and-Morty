//
//  CharacterEpisodesCoordinator.swift
//  Rick&Morty
//
//  Created by Alexander V. on 09.11.2023.
//

import UIKit

final class CharacterEpisodesCoordinator: Coordinator {
    
    var router: Router
    private let characterEpisodesFactory: CharacterEpisodesFactory
    private weak var parentCoordinator: ParentCoordinator?
    
    init(router: Router, characterEpisodesFactory: CharacterEpisodesFactory, parent: ParentCoordinator) {
        self.router = router
        self.characterEpisodesFactory = characterEpisodesFactory
        self.parentCoordinator = parent
    }
    
    func start() {
        let controller = characterEpisodesFactory.makeModule(coordinator: self)
        router.pushViewController(controller, animated: true) { [weak self] in
            guard let self else { return }
            self.parentCoordinator?.removeChild(self)
        }
    }
}

extension CharacterEpisodesCoordinator: CharacterEpisodesViewControllerCoordinator {}
