//
//  CharacterDetailRepository.swift
//  Rick&Morty
//
//  Created by Alexander V. on 09.11.2023.
//

protocol CharacterDetailRepository {
    func fetchCharacterDetail(episodes: [String]) async throws -> [Episode]
}
