//
//  CharacterDetailFactory.swift
//  Rick&Morty
//
//  Created by Alexander V. on 09.11.2023.
//

import UIKit
import Combine

protocol CharacterDetailFactory {
    func makeModule(coordinator: CharacterDetailViewControllerCoordinator) -> UIViewController
}

struct CharacterDetailFactoryImp: CharacterDetailFactory {
    
    let episodes: [String]
    let appDIContainer: AppContainer

    func makeModule(coordinator: CharacterDetailViewControllerCoordinator) -> UIViewController {
        let state = PassthroughSubject<StateController, Never>()
        let characterDetailRepository = CharacterDetailRepositoryImp(network: appDIContainer.networkService)
        let loadCharacterDetailUseCase = LoadCharacterDetailUseCaseImp(
            characterDetailRepository: characterDetailRepository,
            episodes: episodes)
        let viewModel = CharacterDetailViewModelImp(
            state: state,
            loadCharacterDetailUseCase: loadCharacterDetailUseCase,
            dataImageUseCase: appDIContainer.getDataImageUseCase())
        let controller = CharacterDetailViewController(
            viewModel: viewModel,
            coordinator: coordinator)
        controller.navigationItem.title = "Эпизоды"
        return controller
    }
}
