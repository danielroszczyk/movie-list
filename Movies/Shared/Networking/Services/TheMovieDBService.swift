//
//  TheMovieDBService.swift
//  Movies
//
//  Created by Daniel Roszczyk on 19/12/2024.
//

protocol TheMovieDBServiceProtocol: AnyObject {
    func fetchNowPlayingMovies(page: Int, language: String) async throws -> NowPlayingMovies
    func fetchMovieDetails(id: Int, language: String) async throws -> MovieDetails
}

final class TheMovieDBService: BaseNetworkService<MovieRouter>, TheMovieDBServiceProtocol {
    func fetchNowPlayingMovies(page: Int, language: String) async throws -> NowPlayingMovies {
        return try await request(NowPlayingMovies.self, router: .fetchNowPlayingMovies(page: page, language: language))
    }
    
    func fetchMovieDetails(id: Int, language: String) async throws -> MovieDetails {
        return try await request(MovieDetails.self, router: .fetchMovieDetails(id: id, language: language))
    }
}
