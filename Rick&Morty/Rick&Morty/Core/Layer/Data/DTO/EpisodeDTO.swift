//
//  EpisodeDTO.swift
//  Rick&Morty
//
//  Created by Alexander V. on 09.11.2023.
//

struct EpisodeDTO: Decodable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
}
