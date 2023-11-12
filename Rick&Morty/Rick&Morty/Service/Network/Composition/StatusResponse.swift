//
//  StatusResponse.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

enum StatusResponse {
    static let ok = 200...299
    static let clientError = 400...499
    static let serverError = 500...599
}
