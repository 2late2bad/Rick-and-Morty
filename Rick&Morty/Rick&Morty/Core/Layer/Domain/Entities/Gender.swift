//
//  Gender.swift
//  Rick&Morty
//
//  Created by Alexander V. on 13.11.2023.
//

enum Gender {
    case male
    case female
    case genderless
    case unknown
    
    init(description: String?) {
        switch description {
        case AppLocalized.male:
            self = .male
        case AppLocalized.female:
            self = .female
        case AppLocalized.genderless:
            self = .genderless
        default:
            self = .unknown
        }
    }
}

extension Gender: CustomStringConvertible {
    var description: String {
        switch self {
        case .male:
            return AppLocalized.genderMale
        case .female:
            return AppLocalized.genderFemale
        case .genderless:
            return AppLocalized.genderNone
        case .unknown:
            return AppLocalized.genderUnknown
        }
    }
}
