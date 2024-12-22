//
//  TheMovieDBService.swift
//  Movies
//
//  Created by Daniel Roszczyk on 19/12/2024.
//

protocol TheMovieDBServiceProtocol: AnyObject {
    func fetchNowPlayingMovies(_ model: NowPlayingMoviesRequestModel) async throws -> NowPlayingMovies
    func searchMovie(_ model: SearchMovieRequestModel) async throws -> NowPlayingMovies
}

final class TheMovieDBService: BaseNetworkService<MovieRouter>, TheMovieDBServiceProtocol {
    func fetchNowPlayingMovies(_ model: NowPlayingMoviesRequestModel) async throws -> NowPlayingMovies {
        return try await request(NowPlayingMovies.self, router: .fetchNowPlayingMovies(model: model))
    }
    
    func searchMovie(_ model: SearchMovieRequestModel) async throws -> NowPlayingMovies {
        return try await request(NowPlayingMovies.self, router: .searchMovie(model: model))
    }
}
