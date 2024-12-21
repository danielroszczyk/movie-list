//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by Daniel Roszczyk on 21/12/2024.
//

import UIKit

protocol MovieDetailsViewModelProtocol: AnyObject {
    var delegate: MovieDetailsViewModelDelegate? { get set }
    var movieDetails: MovieDetailsViewData { get }
    func didTapFavorite()
    func getFavoriteMovieImage() -> UIImage?
}

protocol MovieDetailsViewModelDelegate: AnyObject {
    func favoriteMovieImage(_ image: UIImage?)
}

protocol MovieDetailsDelegate: AnyObject {
    func didTapFavorite(movieId: Int, isFavorite: Bool)
}

final class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    private let starSelectedImage = UIImage(named: "star_selected")
    private let starUnelectedImage = UIImage(named: "star_unselected")
    private let movieCache: MovieCacheProtocol
    private var favoriteMoviesId: [Int]
    let movieDetails: MovieDetailsViewData
    weak var delegate: MovieDetailsViewModelDelegate?
    weak var movieDetailsDelegate: MovieDetailsDelegate?
    
    init(movieDetails: MovieDetailsViewData,
         movieCache: MovieCacheProtocol = MovieCache.shared) {
        self.movieDetails = movieDetails
        self.movieCache = movieCache
        favoriteMoviesId = movieCache.getFavoriteMoviesId()
    }
    
    func didTapFavorite() {
        guard let movieId = movieDetails.id else { return }
        let image: UIImage?
        
        if favoriteMoviesId.contains(movieId) {
            guard let movieIndex = favoriteMoviesId.firstIndex(of: movieId) else { return }
            favoriteMoviesId.remove(at: movieIndex)
            movieCache.removeFavoriteMovieId(movieId)
            image = starUnelectedImage
            movieDetailsDelegate?.didTapFavorite(movieId: movieId, isFavorite: false)
        } else {
            favoriteMoviesId.append(movieId)
            movieCache.saveFavoriteMovieId(movieId)
            image = starSelectedImage
            movieDetailsDelegate?.didTapFavorite(movieId: movieId, isFavorite: true)
        }
        delegate?.favoriteMovieImage(image)
    }
    
    func getFavoriteMovieImage() -> UIImage? {
        guard let movieId = movieDetails.id else { return nil }
        return favoriteMoviesId.contains(movieId) ? starSelectedImage : starUnelectedImage
    }
}
