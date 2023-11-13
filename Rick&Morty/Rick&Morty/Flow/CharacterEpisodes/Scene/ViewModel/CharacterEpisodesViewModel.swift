//
//  CharacterEpisodesViewModel.swift
//  Rick&Morty
//
//  Created by Alexander V. on 09.11.2023.
//

import Foundation
import Combine

protocol CharacterEpisodesViewModel: BaseViewModel {
    var episodes: [Episode] { get }
}

final class CharacterEpisodesViewModelImp: CharacterEpisodesViewModel {
    
    // MARK: - Public properties
    var state: PassthroughSubject<StateController, Never>
    var episodes: [Episode] { loadEpisodes ?? [] }
    
    // MARK: - Private properties
    private let loadCharacterEpisodesUseCase: LoadCharacterEpisodesUseCase
    private let dataImageUseCase: ImageDataUseCase
    private var loadEpisodes: [Episode]?
    
    // MARK: - Init
    init(state: PassthroughSubject<StateController, Never>,
         loadCharacterEpisodesUseCase: LoadCharacterEpisodesUseCase,
         dataImageUseCase: ImageDataUseCase) {
        self.state = state
        self.loadCharacterEpisodesUseCase = loadCharacterEpisodesUseCase
        self.dataImageUseCase = dataImageUseCase
    }
    
    // MARK: - Methods
    func viewDidLoad() {
        state.send(.loading)
        Task {
            do {
                let episodesResult = try await loadCharacterEpisodesUseCase.execute()
                loadEpisodes = episodesResult
                state.send(.success)
            } catch {
                state.send(.fail(error: error.localizedDescription))
            }
        }
    }
}
