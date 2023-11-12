//
//  CharacterRepositoryImp.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import Foundation

struct CharacterRepositoryImp: CharactersRepository {
    
    let networkService: Network
    
    func fetchCharacters(urlList: String) async throws -> (info: Info, characters: [Character]) {
        let url = URL(string: urlList)
        return try await networkService.request(url: url, type: ResultsCharacterDTO.self).toDomain()
    }
}
