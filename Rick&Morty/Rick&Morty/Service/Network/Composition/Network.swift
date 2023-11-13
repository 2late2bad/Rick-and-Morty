//
//  Network.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import Foundation

protocol Network {
    func request<T: Decodable>(url: URL?, type: T.Type) async throws -> T
}
