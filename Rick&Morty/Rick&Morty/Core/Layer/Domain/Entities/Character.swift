//
//  Character.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

struct Character {
    let id: Int
    let name: String
    let status: StatusCharacter?
    let specie: Specie
    let urlCharacter: String
    let urlImage: String?
    let origin: Origin
    let location: Location
    let gender: Gender
    let episode: [String]
}
