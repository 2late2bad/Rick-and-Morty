//
//  ResultsCharacterDTO.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

struct ResultsCharacterDTO: Decodable {
    let info: InfoDTO
    let results: [CharacterDTO]
}
