//
//  AuthenticationRouter.swift
//  Movies
//
//  Created by Daniel Roszczyk on 20/12/2024.
//

import Foundation

enum AuthenticationRouter: URLRequestConvertible {
    case getGuestSession
    
    private var method: String {
        switch self {
        case .getGuestSession:
            return "GET"
        }
    }
    
    private var path: String {
        switch self {
        case .getGuestSession:
            return "/authentication/guest_session/new"
        }
    }
    
    func makeURLRequest() throws -> URLRequest {
        guard let url = URL(string: AppConstants.TheMovieDBApi.baseURL + path) else {
            throw NetworkError.invalidURL
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.setValue("Bearer \(AppConstants.TheMovieDBApi.apiReadAccessToken)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.timeoutInterval = 10
        
        return urlRequest
    }
}
