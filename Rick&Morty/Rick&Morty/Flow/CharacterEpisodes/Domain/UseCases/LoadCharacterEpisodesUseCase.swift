//
//  LoadCharacterEpisodesUseCase.swift
//  Rick&Morty
//
//  Created by Alexander V. on 09.11.2023.
//

protocol LoadCharacterEpisodesUseCase {
    func execute() async throws -> [Episode]
}

struct LoadCharacterEpisodesUseCaseImp: LoadCharacterEpisodesUseCase {
    
    private(set) var characterEpisodesRepository: CharacterEpisodesRepository
    private(set) var episodes: [String]
    
    func execute() async throws -> [Episode] {
        try await characterEpisodesRepository.fetchCharacter(episodes: episodes)
    }
}
