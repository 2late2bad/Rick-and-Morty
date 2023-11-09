//
//  CharacterDetailRepositoryImp.swift
//  Rick&Morty
//
//  Created by Alexander V. on 09.11.2023.
//

import Foundation

struct CharacterDetailRepositoryImp: CharacterDetailRepository {

    private(set) var network: Network
    
    func fetchCharacterDetail(episodes: [String]) async throws -> [Episode] {
        // TODO: - refactor
        let url = URL(string: "https://rickandmortyapi.com/api/episode/1,2,3,4,5,10,12,14,17,28,30")
        let result = try await network.request(url: url, type: [EpisodeDTO].self)
        return result.map { $0.toDomain() }
    }
}
