//
//  NetworkService+ext.swift
//  Rick&Morty
//
//  Created by Alexander V. on 09.11.2023.
//

import Foundation

extension NetworkService: RemoteImageDataService {
    func request(url: URL?) async -> Data? {
        guard let url else { return nil }
        do {
            let (data: data, request: request) = try await session.data(from: url)
            return (data: data, request: request).data
        } catch {
            return nil
        }
    }
}
