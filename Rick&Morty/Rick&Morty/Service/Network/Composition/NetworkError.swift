//
//  NetworkError.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import Foundation

enum NetworkError: Error {
    case clientError
    case serverError
    case unknownError
    case invalidURL
    case errorDecoding
}

extension NetworkError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .clientError:
            return NSLocalizedString("Клиентская ошибка", comment: "")
        case .serverError:
            return NSLocalizedString("Серверная ошибка", comment: "")
        case .unknownError:
            return NSLocalizedString("Неизвестная ошибка", comment: "")
        case .invalidURL:
            return NSLocalizedString("Невалидный URL", comment: "")
        case .errorDecoding:
            return NSLocalizedString("Ошибка декодирования", comment: "")
        }
    }
}
