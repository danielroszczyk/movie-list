//
//  TheMovieDBService.swift
//  Movies
//
//  Created by Daniel Roszczyk on 19/12/2024.
//

protocol TheMovieDBServiceProtocol: AnyObject {
    func fetchNowPlayingMovies(_ model: NowPlayingMoviesRequestModel) async throws -> MoviesResponse
    func searchMovie(_ model: SearchMovieRequestModel) async throws -> MoviesResponse
}

final class TheMovieDBService: BaseNetworkService<MovieRouter>, TheMovieDBServiceProtocol {
    func fetchNowPlayingMovies(_ model: NowPlayingMoviesRequestModel) async throws -> MoviesResponse {
        return try await request(MoviesResponse.self, router: .fetchNowPlayingMovies(model: model))
    }
    
    func searchMovie(_ model: SearchMovieRequestModel) async throws -> MoviesResponse {
        return try await request(MoviesResponse.self, router: .searchMovie(model: model))
    }
}
