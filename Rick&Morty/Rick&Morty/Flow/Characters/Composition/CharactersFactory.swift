//
//  CharactersFactory.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import UIKit
import Combine

protocol CharactersFactory {
    func makeCharactersViewController(coordinator: CharactersViewControllerCoordinator) -> UIViewController
    func makeItemTabBar(router: Router)
//    func makePostDetailCoordinator(router: Router, id: Int, parentCoordinator: ParentCoordinator) -> Coordinator
    func makeCharacterDetailCoordinator(router: Router, parent: ParentCoordinator, urlDetail: String) -> Coordinator
}

struct CharactersFactoryImp: CharactersFactory {
    
    let appDIContainer: AppContainer
    let urlList: String
    
    func makeCharactersViewController(coordinator: CharactersViewControllerCoordinator) -> UIViewController {
        let state = PassthroughSubject<StateController, Never>()
        let network = NetworkService()
        let characterRepository = CharacterRepositoryImp(networkService: network)
        let loadCharactersUseCase = LoadCharacterUseCaseImp(characterRepository: characterRepository, url: urlList)
        let lastPageValidationUseCase = LastPageValidationUseCaseImp()
        let viewModel = CharacterViewModelImp(
            loadCharactersUseCase: loadCharactersUseCase,
            state: state,
            lastPageValidationUseCase: lastPageValidationUseCase, imageDataUseCase: appDIContainer.getDataImageUseCase())
        let controller = CharactersViewController(viewModel: viewModel, coordinator: coordinator)
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
    
    func makeCharacterDetailCoordinator(router: Router, parent: ParentCoordinator, urlDetail: String) -> Coordinator {
        let factory = CharacterDetailFactoryImp(urlDetail: urlDetail, appDIContainer: appDIContainer)
        let coordinator = CharacterDetailCoordinator(router: router,
                                                     characterDetailFactory: factory,
                                                     parent: parent)
        return coordinator
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
