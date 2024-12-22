//
//  TheMovieDBRoouter.swift
//  Movies
//
//  Created by Daniel Roszczyk on 19/12/2024.
//

import Foundation

enum MovieRouter: URLRequestConvertible {
    case fetchNowPlayingMovies(model: NowPlayingMoviesRequestModel)
    case searchMovie(model: SearchMovieRequestModel)
    
    private var method: String {
        switch self {
        case .fetchNowPlayingMovies:
            return "GET"
        case .searchMovie:
            return "GET"
        }
    }
    
    private var queryItems: [URLQueryItem] {
        switch self {
        case let .fetchNowPlayingMovies(model):
            var items: [URLQueryItem] = []
            
            if let language = model.language {
                items.append(URLQueryItem(name: "language", value: language))
            }
            if let page = model.page {
                items.append(URLQueryItem(name: "page", value: "\(page)"))
            }
            if let region = model.region {
                items.append(URLQueryItem(name: "region", value: region))
            }
            return items
        case let .searchMovie(model):
            var items: [URLQueryItem] = [URLQueryItem(name: "query", value: model.query)]
            
            if let includeAdult = model.includeAdult {
                items.append(URLQueryItem(name: "include_adult", value: includeAdult.description))
            }
            if let language = model.language {
                items.append(URLQueryItem(name: "language", value: language))
            }
            if let primaryReleaseYear = model.primaryReleaseYear {
                items.append(URLQueryItem(name: "primary_release_year", value: primaryReleaseYear))
            }
            if let page = model.page {
                items.append(URLQueryItem(name: "page", value: "\(page)"))
            }
            if let region = model.region {
                items.append(URLQueryItem(name: "region", value: region))
            }
            if let year = model.year {
                items.append(URLQueryItem(name: "year", value: year))
            }
            
            return items
        }
    }
    
    private var path: String {
        switch self {
        case .fetchNowPlayingMovies:
            return "/movie/now_playing"
        case .searchMovie:
            return "/search/movie"
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
        
        return urlRequest
    }
}
