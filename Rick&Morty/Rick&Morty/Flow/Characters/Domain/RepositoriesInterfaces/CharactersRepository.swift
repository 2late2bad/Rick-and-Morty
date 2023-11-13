//
//  CharactersRepository.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

protocol CharactersRepository {
    func fetchCharacters(urlList: String) async throws -> (info: Info, characters: [Character])
}
