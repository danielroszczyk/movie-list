//
//  NowPlayingMoviesViewModel.swift
//  Movies
//
//  Created by Daniel Roszczyk on 20/12/2024.
//

import UIKit

protocol NowPlayingMoviesProtocol: AnyObject {
    var delegate: NewPlayingMoviesCellModelDelegate? { get set }
    func fetchNowPlayingMovies() async
    func getMovieCellModel(index: Int) -> NewPlayingMoviesCellModel?
    func getMovieDetailsData(index: Int) -> MovieDetailsViewData?
    func numberOfMovies() -> Int
    func didTapFavorite(index: Int)
    func didTapFavorite(movieId: Int, isFavorite: Bool)
    func movieSearched(text: String)
}

protocol NewPlayingMoviesCellModelDelegate: AnyObject {
    func reloadData()
    func reloadCell(index: Int)
}

final class NowPlayingMoviesViewModel: NowPlayingMoviesProtocol {
    private let movieService: TheMovieDBServiceProtocol
    private let movieCache: MovieCacheProtocol
    private var nowPlayingMovies: MoviesResponse?
    private var movies: [Movie] = []
    private var filteredMovies: [Movie] = []
    private var favoriteMoviesId: [Int]
    private var currentPage = 0
    private var searchMovieText: String = ""
    weak var delegate: NewPlayingMoviesCellModelDelegate?
    
    init(movieService: TheMovieDBServiceProtocol = TheMovieDBService(),
         movieCache: MovieCacheProtocol = MovieCache.shared) {
        self.movieService = movieService
        self.movieCache = movieCache
        self.favoriteMoviesId = movieCache.getFavoriteMoviesId()
    }
    
    func fetchNowPlayingMovies() async {
        do {
            if currentPage < nowPlayingMovies?.totalPages ?? 1 {
                let requestModel = NowPlayingMoviesRequestModel(page: currentPage + 1)
                let nowPlayingMovies = try await movieService.fetchNowPlayingMovies(requestModel)
                
                if nowPlayingMovies.results.count > 0 {
                    movies.append(contentsOf: nowPlayingMovies.results)
                    filteredMovies = getFilteredMovies()
                    currentPage += 1
                    delegate?.reloadData()
                }
                self.nowPlayingMovies = nowPlayingMovies
            }
        } catch {
            print(error)
        }
    }
    
    func getMovieCellModel(index: Int) -> NewPlayingMoviesCellModel? {
        guard let movie = getFilteredMovie(index: index) else { return nil }
        let favoriteImage = getFavoriteMovieImage(movieId: movie.id)
        
        let baseURL = AppConstants.TheMovieDBApi.imageW92BaseURL
        let movieImageURL: URL?
        
        if let posterPath = movie.posterPath {
            let urlString = baseURL + posterPath
            movieImageURL = URL(string: urlString)
        } else {
            movieImageURL = nil
        }
        
        let item = NewPlayingMoviesCellModel(title: movie.title, movieImageURL: movieImageURL, favorite: favoriteImage)
        return item
    }
    
    func numberOfMovies() -> Int {
        filteredMovies.count
    }
    
    func getMovieDetailsData(index: Int) -> MovieDetailsViewData? {
        guard let movie = getFilteredMovie(index: index) else { return nil }
        let voteAverage = movie.voteAverage
        let rating: String? = if let voteAverage { "\(voteAverage)" } else { nil }
        
        let posterUrl: URL?
        
        if let posterPath = movie.posterPath {
            let urlString = AppConstants.TheMovieDBApi.imageOriginalBaseURL + posterPath
            posterUrl = URL(string: urlString)
        } else {
            posterUrl = nil
        }
        
        let movieDetails = MovieDetailsViewData(
            id: movie.id,
            title: movie.title,
            releaseDate: movie.releaseDate,
            rating: rating,
            overview: movie.overview,
            posterImageURL: posterUrl)
        
        return movieDetails
    }
    
    func didTapFavorite(index: Int) {
        guard let movie = getFilteredMovie(index: index) else { return }
        
        if favoriteMoviesId.contains(movie.id) {
            guard let movieIndex = favoriteMoviesId.firstIndex(of: movie.id) else { return }
            favoriteMoviesId.remove(at: movieIndex)
            movieCache.removeFavoriteMovieId(movie.id)
        } else {
            favoriteMoviesId.append(movie.id)
            movieCache.saveFavoriteMovieId(movie.id)
        }
        delegate?.reloadCell(index: index)
    }
    
    func didTapFavorite(movieId: Int, isFavorite: Bool) {
        if isFavorite {
            favoriteMoviesId.append(movieId)
        } else {
            guard let movieIndex = favoriteMoviesId.firstIndex(of: movieId) else { return }
            favoriteMoviesId.remove(at: movieIndex)
        }
        guard let index = filteredMovies.firstIndex(where: { $0.id == movieId }) else { return }
        delegate?.reloadCell(index: index)
    }
    
    func movieSearched(text: String) {
        searchMovieText = text
        filteredMovies = getFilteredMovies()
        delegate?.reloadData()
    }
    
    private func getFavoriteMovieImage(movieId: Int) -> UIImage? {
        return favoriteMoviesId.contains(movieId) ? UIImage(named: "star_selected") : UIImage(named: "star_unselected")
    }
    
    private func getFilteredMovie(index: Int) -> Movie? {
        guard filteredMovies.indices.contains(index) else {
            return nil
        }
        return filteredMovies[index]
    }
    
    private func getFilteredMovies() -> [Movie] {
        guard !searchMovieText.isEmpty else {
            filteredMovies = movies
            return filteredMovies
        }
        return movies.filter {
            guard let title = $0.title,
                  !title.isEmpty else { return false }
            return title.contains(searchMovieText)
        }
    }
}
