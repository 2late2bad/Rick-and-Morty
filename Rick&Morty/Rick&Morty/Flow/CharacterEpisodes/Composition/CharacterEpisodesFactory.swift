//
//  CharacterEpisodesFactory.swift
//  Rick&Morty
//
//  Created by Alexander V. on 09.11.2023.
//

import UIKit
import Combine

protocol CharacterEpisodesFactory {
    func makeModule(coordinator: CharacterEpisodesViewControllerCoordinator) -> UIViewController
}

struct CharacterEpisodesFactoryImp: CharacterEpisodesFactory {
    
    let episodes: [String]
    let appDIContainer: AppContainer

    func makeModule(coordinator: CharacterEpisodesViewControllerCoordinator) -> UIViewController {
        let state = PassthroughSubject<StateController, Never>()
        let characterEpisodesRepository = CharacterEpisodesRepositoryImp(network: appDIContainer.networkService)
        let loadCharacterEpisodesUseCase = LoadCharacterEpisodesUseCaseImp(
            characterEpisodesRepository: characterEpisodesRepository,
            episodes: episodes)
        let viewModel = CharacterEpisodesViewModelImp(
            state: state,
            loadCharacterEpisodesUseCase: loadCharacterEpisodesUseCase,
            dataImageUseCase: appDIContainer.getDataImageUseCase())
        let controller = CharacterEpisodesViewController(
            viewModel: viewModel,
            coordinator: coordinator)
        controller.navigationItem.title = R.Name.charEpisodesTitleVC
        return controller
    }
}
