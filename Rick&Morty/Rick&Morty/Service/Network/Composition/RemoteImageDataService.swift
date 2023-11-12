//
//  RemoteImageDataService.swift
//  Rick&Morty
//
//  Created by Alexander V. on 09.11.2023.
//

import Foundation

protocol RemoteImageDataService {
    func request(url: URL?) async -> Data?
}
