//
//  TheMovieDBRoouter.swift
//  Movies
//
//  Created by Daniel Roszczyk on 19/12/2024.
//

import Foundation

enum MovieRouter: URLRequestConvertible {
    case fetchNowPlayingMovies(page: Int, language: String)
    case fetchMovieDetails(id: Int, language: String)
    
    private var method: String {
        switch self {
        case .fetchNowPlayingMovies:
            return "GET"
        case .fetchMovieDetails:
            return "GET"
        }
    }
    
    private var queryItems: [URLQueryItem] {
        switch self {
        case let .fetchNowPlayingMovies(page, language):
            return [
                URLQueryItem(name: "language", value: language),
                URLQueryItem(name: "page", value: "\(page)")
            ]
        case let .fetchMovieDetails(_, language):
            return [
                URLQueryItem(name: "language", value: language)
            ]
        }
    }
    
    private var bodyParameters: Data? {
        switch self {
        case .fetchNowPlayingMovies:
            return nil
        case .fetchMovieDetails:
            return nil
        }
    }
    
    private var path: String {
        switch self {
        case .fetchNowPlayingMovies:
            return "/movie/now_playing"
        case let .fetchMovieDetails(id, _):
            return "/movie/\(id)"
        }
    }
    
    func makeURLRequest() throws -> URLRequest {
        guard let url = URL(string: AppConstants.TheMovieDBApi.baseURL + path),
              let urlWithQueryItems = url.appending(queryItems) else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: urlWithQueryItems)
        urlRequest.httpMethod = method
        urlRequest.setValue("Bearer \(AppConstants.TheMovieDBApi.apiReadAccessToken)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.timeoutInterval = 10
        urlRequest.httpBody = bodyParameters
        
        return urlRequest
    }
}
