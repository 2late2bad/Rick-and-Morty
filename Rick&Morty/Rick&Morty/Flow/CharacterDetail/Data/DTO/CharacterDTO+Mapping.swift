//
//  CharacterDTO+Mapping.swift
//  Rick&Morty
//
//  Created by Alexander V. on 09.11.2023.
//

extension EpisodeDTO {
    func toDomain() -> Episode {
        Episode(name: name, airDate: airDate, episode: episode)
    }
}
