//
//  NetworkService.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

import Foundation

struct NetworkService: Network {
    
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T>(url: URL?, type: T.Type) async throws -> T where T : Decodable {
        guard let url else { throw NetworkError.invalidURL }
        return try await makeRequest(url: url)
    }
}

private extension NetworkService {
    
    func makeRequest<T: Decodable>(url: URL) async throws -> T {
        let request = try await session.data(from: url)
        return try validateResponse(request: request)
    }
    
    func validateResponse<T: Decodable>(
        request: (data: Data, httpResponse: URLResponse)
    ) throws -> T {
        guard let httpResponse = request.httpResponse as? HTTPURLResponse else {
            throw NetworkError.unknownError
        }
        
        switch httpResponse.statusCode {
        case StatusResponse.ok:
            return try decodeModel(data: request.data)
        case StatusResponse.clientError:
            throw NetworkError.clientError
        case StatusResponse.serverError:
            throw NetworkError.serverError
        default:
            throw NetworkError.unknownError
        }
    }
    
    func decodeModel<T: Decodable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let model = try? decoder.decode(T.self, from: data)
        guard let model else { throw NetworkError.errorDecoding }
        return model
    }
}
