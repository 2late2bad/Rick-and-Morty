//
//  StatusCharacter.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

enum StatusCharacter: String {
    case alive
    case dead
    case unknown
    
    init?(status: String?) {
        guard
            let status = StatusCharacter(rawValue: status?.lowercased() ?? .empty)
        else {
            return nil
        }
        self = status
    }
}

extension StatusCharacter: CustomStringConvertible {
    var description: String {
        switch self {
        case .alive:
            return AppLocalized.statusAlive
        case .dead:
            return AppLocalized.statusDead
        case .unknown:
            return AppLocalized.statusUnknown
        }
    }
    
    var isAlive: Bool? {
        switch self {
        case .alive:
            return true
        case .dead:
            return false
        case .unknown:
            return nil
        }
    }
}
