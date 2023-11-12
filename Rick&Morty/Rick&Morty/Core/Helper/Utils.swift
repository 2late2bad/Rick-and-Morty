//
//  Utils.swift
//  Rick&Morty
//
//  Created by Alexander V. on 10.11.2023.
//

import Foundation

struct Utils {
    static func createCombinedURL(from urls: [String]) -> String? {
        let episodeIds = urls.compactMap { url -> Int? in
            if let lastPathComponent = url.components(separatedBy: "/").last,
                let id = Int(lastPathComponent) {
                return id
            }
            return nil
        }
        
        if episodeIds.isEmpty { return nil }
        
        let combined = episodeIds.map { String($0) }.joined(separator: ",")
        return Endpoint.episodeURL + "/" + combined
    }
}
