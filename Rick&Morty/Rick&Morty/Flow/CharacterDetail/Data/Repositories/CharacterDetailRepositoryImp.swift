//
//  CharacterDetailRepositoryImp.swift
//  Rick&Morty
//
//  Created by Alexander V. on 09.11.2023.
//

import Foundation

struct CharacterDetailRepositoryImp: CharacterDetailRepository {
    
    private(set) var network: Network
    
    func fetchCharacterDetail(urlDetail: String) async throws -> Character {
        let url = URL(string: urlDetail)
        let result = try await network.request(url: url, type: CharacterDTO.self)
        return result.toDomain()
    }
}
