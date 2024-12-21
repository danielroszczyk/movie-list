//
//  MovieCache.swift
//  Movies
//
//  Created by Daniel Roszczyk on 21/12/2024.
//

import Foundation

protocol MovieCacheProtocol: AnyObject {
    func getFavoriteMoviesId() -> [Int]
    func saveFavoriteMovieId(_ movieId: Int)
    func removeFavoriteMovieId(_ movieId: Int)
}

class MovieCache: MovieCacheProtocol {
    private let userDefaults: UserDefaults
    private let favoriteMoviesIdKey = "FavoriteMoviesId"
    static let shared = MovieCache()
    
    private init() {
        self.userDefaults = UserDefaults()
    }
    
    func getFavoriteMoviesId() -> [Int] {
        userDefaults.array(forKey: favoriteMoviesIdKey) as? [Int] ?? [Int]()
    }
    
    func saveFavoriteMovieId(_ movieId: Int) {
        var favoriteMoviesId = getFavoriteMoviesId()
        favoriteMoviesId.append(movieId)
        userDefaults.set(favoriteMoviesId, forKey: favoriteMoviesIdKey)
    }
    
    func removeFavoriteMovieId(_ movieId: Int) {
        var favoriteMoviesId = getFavoriteMoviesId()
        guard let index = favoriteMoviesId.firstIndex(where: { $0 == movieId }) else { return }
        favoriteMoviesId.remove(at: index)
        userDefaults.set(favoriteMoviesId, forKey: favoriteMoviesIdKey)
    }
}
