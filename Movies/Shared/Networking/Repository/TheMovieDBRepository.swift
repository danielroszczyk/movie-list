//
//  TheMovieDBRepository.swift
//  Movies
//
//  Created by Daniel Roszczyk on 19/12/2024.
//

protocol TheMovieDBRepositoryProtocol: AnyObject {
    func fetchNowPlayingMovies(page: Int, language: String) async throws -> NowPlayingMovies
    func fetchMovieDetails(id: Int, language: String) async throws -> MovieDetails
}

final class TheMovieDBRepository: TheMovieDBRepositoryProtocol {
    private let networkService: TheMovieDBRepositoryProtocol
    
    init(networkService: TheMovieDBRepositoryProtocol) {
        self.networkService = networkService
    }
    
    func fetchNowPlayingMovies(page: Int = 1, language: String = "en-US") async throws -> NowPlayingMovies {
        return try await networkService.fetchNowPlayingMovies(page: page, language: language)
    }
    
    func fetchMovieDetails(id: Int, language: String = "en-US") async throws -> MovieDetails {
        return try await networkService.fetchMovieDetails(id: id, language: language)
    }
}
