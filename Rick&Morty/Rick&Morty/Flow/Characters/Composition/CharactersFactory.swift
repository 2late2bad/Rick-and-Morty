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
    func makeCharacterDetailCoordinator(router: Router, parent: ParentCoordinator, episodes: [String]) -> Coordinator
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
        controller.navigationItem.title = R.Name.charTitleVC
        return controller
    }
    
    func makeItemTabBar(router: Router) {
        makeItemTabBar(
            router: router,
            title: R.Name.charTitleVC,
            image: R.Images.charItemTabBarDefault,
            selectedImage: R.Images.charItemTabBarSelected
        )
    }
    
    func makeCharacterDetailCoordinator(router: Router, parent: ParentCoordinator, episodes: [String]) -> Coordinator {
        let factory = CharacterEpisodesFactoryImp(episodes: episodes, appDIContainer: appDIContainer)
        let coordinator = CharacterEpisodesCoordinator(router: router,
                                                       characterEpisodesFactory: factory,
                                                       parent: parent)
        return coordinator
    }
}

extension CharactersFactoryImp: ItemTabBarFactory {}
