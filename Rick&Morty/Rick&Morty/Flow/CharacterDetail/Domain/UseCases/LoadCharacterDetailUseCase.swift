//
//  LoadCharacterDetailUseCase.swift
//  Rick&Morty
//
//  Created by Alexander V. on 09.11.2023.
//

protocol LoadCharacterDetailUseCase {
    func execute() async throws -> [Episode]
}

struct LoadCharacterDetailUseCaseImp: LoadCharacterDetailUseCase {
    
    private(set) var characterDetailRepository: CharacterDetailRepository
    private(set) var episodes: [String]
    
    func execute() async throws -> [Episode] {
        try await characterDetailRepository.fetchCharacterDetail(episodes: episodes)
    }
}
