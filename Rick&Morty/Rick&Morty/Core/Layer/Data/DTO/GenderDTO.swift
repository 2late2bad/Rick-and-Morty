//
//  GenderDTO.swift
//  Rick&Morty
//
//  Created by Alexander V. on 13.11.2023.
//

enum GenderDTO: String, Decodable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown = "unknown"
}
