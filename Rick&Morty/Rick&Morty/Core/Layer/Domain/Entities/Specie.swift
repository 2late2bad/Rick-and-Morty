//
//  Specie.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

enum Specie {
    case alien
    case human
    case other(type: String?)
    
    init(specie: String?) {
        switch specie {
        case AppLocalized.alien:
            self = .alien
        case AppLocalized.human:
            self = .human
        default:
            self = .other(type: specie)
        }
    }
}

extension Specie: CustomStringConvertible {
    var description: String {
        switch self {
        case .alien:
            return AppLocalized.specieAlien
        case .human:
            return AppLocalized.specieHuman
        case .other(type: let typeSpecie):
            let typeSpecie = typeSpecie ?? AppLocalized.unknown
            return "\(AppLocalized.specie) \(typeSpecie)"
        }
    }
}
