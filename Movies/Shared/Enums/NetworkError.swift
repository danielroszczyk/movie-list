//
//  NetworkError.swift
//  Movies
//
//  Created by Daniel Roszczyk on 19/12/2024.
//

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case redirection(_ statusCode: Int)
    case client(_ statusCode: Int)
    case server(_ statusCode: Int)
    case failedDecoding
    case failedAuthorization
    case unknown

    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "Invalid response."
        case .redirection(let statusCode):
            return "Status code: \(statusCode). Further action needs to be taken in order to complete the request."
        case .client(let statusCode):
            return "Status code: \(statusCode). The request contains bad syntax or cannot be fulfilled."
        case .server(let statusCode):
            return "Status code: \(statusCode). The server failed to fulfill an apparently valid request"
        case .failedDecoding:
            return "Failed to decode model."
        case .failedAuthorization:
            return "Autorization failed"
        case .unknown:
            return "Unexpected error occured."
        }
    }
}
