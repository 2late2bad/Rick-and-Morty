//
//  ImageDataRepository.swift
//  Rick&Morty
//
//  Created by Alexander V. on 09.11.2023.
//

import Foundation

protocol ImageDataRepository {
    func fetchData(url: URL?) async -> Data?
    func getFromCache(url: URL?) -> Data?
}
