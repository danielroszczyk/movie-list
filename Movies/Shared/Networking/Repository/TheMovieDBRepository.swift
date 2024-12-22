//
//  TheMovieDBRepository.swift
//  Movies
//
//  Created by Daniel Roszczyk on 19/12/2024.
//

protocol TheMovieDBRepositoryProtocol: AnyObject {
    func fetchNowPlayingMovies(_ model: NowPlayingMoviesRequestModel) async throws -> NowPlayingMovies
    func searchMovie(_ model: SearchMovieRequestModel) async throws -> NowPlayingMovies
}

final class TheMovieDBRepository: TheMovieDBRepositoryProtocol {
    private let networkService: TheMovieDBRepositoryProtocol
    
    init(networkService: TheMovieDBRepositoryProtocol) {
        self.networkService = networkService
    }
    
    func fetchNowPlayingMovies(_ model: NowPlayingMoviesRequestModel) async throws -> NowPlayingMovies {
        return try await networkService.fetchNowPlayingMovies(model)
    }
    
    func searchMovie(_ model: SearchMovieRequestModel) async throws -> NowPlayingMovies {
        return try await networkService.searchMovie(model)
    }
}
