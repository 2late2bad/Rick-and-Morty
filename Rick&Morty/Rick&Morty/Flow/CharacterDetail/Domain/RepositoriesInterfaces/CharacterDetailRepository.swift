//
//  CharacterDetailRepository.swift
//  Rick&Morty
//
//  Created by Alexander V. on 09.11.2023.
//

protocol CharacterDetailRepository {
    func fetchCharacterDetail(urlDetail: String) async throws -> Character
}
