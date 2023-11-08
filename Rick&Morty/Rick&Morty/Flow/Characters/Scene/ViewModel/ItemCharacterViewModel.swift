//
//  ItemCharacterViewModel.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

struct ItemCharacterViewModel {
    private let character: Character
    
    init(character: Character) {
        self.character = character
    }
    
    var name: String {
        character.name
    }
    
    var specie: String {
        character.specie.description
    }
    
    var status: String {
        character.status?.description ?? ""
    }
}
