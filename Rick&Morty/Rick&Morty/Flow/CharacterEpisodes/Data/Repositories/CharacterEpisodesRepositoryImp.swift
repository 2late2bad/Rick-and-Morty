//
//  CharacterEpisodesRepositoryImp.swift
//  Rick&Morty
//
//  Created by Alexander V. on 09.11.2023.
//

import Foundation

struct CharacterEpisodesRepositoryImp: CharacterEpisodesRepository {

    private(set) var network: Network
    
    func fetchCharacter(episodes: [String]) async throws -> [Episode] {
        
        let urlEpisodes = Utils.createCombinedURL(from: episodes)
        
        guard let urlEpisodes else { throw NetworkError.invalidURL }
        
        if episodes.count == 1 {
            let result = try await network.request(url: URL(string: urlEpisodes), type: EpisodeDTO.self)
            return [result.toDomain()]
        } else {
            let result = try await network.request(url: URL(string: urlEpisodes), type: [EpisodeDTO].self)
            return result.map { $0.toDomain() }
        }
    }
}
