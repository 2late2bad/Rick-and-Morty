//
//  LoadCharacterDetailUseCase.swift
//  Rick&Morty
//
//  Created by Alexander V. on 09.11.2023.
//

protocol LoadCharacterDetailUseCase {
    func execute() async throws -> Character
}

struct LoadCharacterDetailUseCaseImp: LoadCharacterDetailUseCase {
    
    private(set) var characterDetailRepository: CharacterDetailRepository
    private(set) var urlDetail: String
    
    func execute() async throws -> Character {
        try await characterDetailRepository.fetchCharacterDetail(urlDetail: urlDetail)
    }
}
