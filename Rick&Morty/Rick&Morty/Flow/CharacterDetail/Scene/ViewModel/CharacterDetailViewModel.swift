//
//  CharacterDetailViewModel.swift
//  Rick&Morty
//
//  Created by Alexander V. on 09.11.2023.
//

import Foundation
import Combine

protocol CharacterDetailViewModel: BaseViewModel {
    var episodes: [Episode] { get }
}

final class CharacterDetailViewModelImp: CharacterDetailViewModel {
    
    // MARK: - Public properties
    var state: PassthroughSubject<StateController, Never>
    var episodes: [Episode] { loadEpisodes ?? [] }
    
    // MARK: - Private properties
    private let loadCharacterDetailUseCase: LoadCharacterDetailUseCase
    private let dataImageUseCase: ImageDataUseCase
    private var loadEpisodes: [Episode]?
    
    init(state: PassthroughSubject<StateController, Never>,
         loadCharacterDetailUseCase: LoadCharacterDetailUseCase,
         dataImageUseCase: ImageDataUseCase) {
        self.state = state
        self.loadCharacterDetailUseCase = loadCharacterDetailUseCase
        self.dataImageUseCase = dataImageUseCase
    }
    
    func viewDidLoad() {
        state.send(.loading)
        Task {
            do {
                let episodesResult = try await loadCharacterDetailUseCase.execute()
                loadEpisodes = episodesResult
                state.send(.success)
            } catch {
                state.send(.fail(error: error.localizedDescription))
            }
        }
    }
}
