//
//  CharacterEpisodesRepository.swift
//  Rick&Morty
//
//  Created by Alexander V. on 09.11.2023.
//

protocol CharacterEpisodesRepository {
    func fetchCharacter(episodes: [String]) async throws -> [Episode]
}
