//
//  CharacterDTO+Mapping.swift
//  Rick&Morty
//
//  Created by Alexander V. on 09.11.2023.
//

extension CharacterDTO {
    func toDomain() -> Character {
        let statusChar = StatusCharacter(status: status)
        let specie = Specie(specie: species)
        let origin = Origin(name: origin.name, url: origin.url)
        let location = Location(
            name: location.name,
            type: location.type,
            dimension: location.dimension,
            url: location.url)
        return Character(
            id: id,
            name: name,
            status: statusChar,
            specie: specie,
            urlCharacter: url,
            urlImage: image,
            origin: origin,
            location: location)
    }
}
