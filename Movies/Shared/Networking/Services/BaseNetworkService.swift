//
//  BaseNetworkService.swift
//  Movies
//
//  Created by Daniel Roszczyk on 19/12/2024.
//

import Foundation

protocol URLRequestConvertible {
    func makeURLRequest() throws -> URLRequest
}

class BaseNetworkService<Router: URLRequestConvertible> {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    private func handleResponse(data: Data, response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        let statusCode = httpResponse.statusCode
        
        switch statusCode {
        case 200...299:
            break
        case 300...399:
            throw NetworkError.redirection(statusCode)
        case 400...499:
            throw NetworkError.client(statusCode)
        case 500...599:
            throw NetworkError.server(statusCode)
        default:
            throw NetworkError.unknown
        }
    }
    
    func request<T: Decodable>(_ returnType: T.Type, router: Router) async throws -> T {
        let request = try router.makeURLRequest()
        let (data, response) = try await urlSession.data(for: request)
//        let dataString = String(data: data, encoding: .utf8) ?? ""
//        print(dataString)
        try handleResponse(data: data, response: response)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let decodedData = try decoder.decode(returnType, from: data)
            return decodedData
        } catch {
            throw NetworkError.failedDecoding
        }
    }
}
