//
//  URL.swift
//  Movies
//
//  Created by Daniel Roszczyk on 20/12/2024.
//

import Foundation

extension URL {
    func appending(_ items: [URLQueryItem]) -> URL? {
        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }
        var queryItems: [URLQueryItem] = urlComponents.queryItems ?? []
        queryItems.append(contentsOf: items)
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
}
