//
//  CharacterDetailCoordinator.swift
//  Rick&Morty
//
//  Created by Alexander V. on 09.11.2023.
//

import UIKit

final class CharacterDetailCoordinator: Coordinator {
    
    var router: Router
    private let characterDetailFactory: CharacterDetailFactory
    private weak var parentCoordinator: ParentCoordinator?
    
    init(router: Router, characterDetailFactory: CharacterDetailFactory, parent: ParentCoordinator) {
        self.router = router
        self.characterDetailFactory = characterDetailFactory
        self.parentCoordinator = parent
    }
    
    func start() {
        let controller = characterDetailFactory.makeModule(coordinator: self)
        router.pushViewController(controller, animated: true) { [weak self] in
            guard let self else { return }
            self.parentCoordinator?.removeChild(self)
        }
    }
}

extension CharacterDetailCoordinator: CharacterDetailViewControllerCoordinator {
    func didTapOriginButton() {
        print("origin")
    }
    
    func didTapLocationButton() {
        print("location")
    }
}
