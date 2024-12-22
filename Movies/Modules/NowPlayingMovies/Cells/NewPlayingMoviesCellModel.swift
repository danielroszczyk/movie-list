//
//  NewPlayingMoviesCellModel.swift
//  Movies
//
//  Created by Daniel Roszczyk on 20/12/2024.
//

import Foundation
import UIKit

struct NewPlayingMoviesCellModel {
    let title: String
    let movieImageURL: URL?
    let favorite: UIImage?
    
    init?(movie: Movie, favorite: UIImage?) {
        guard let title = movie.title else { return nil }
        self.title = title
        let baseURL = AppConstants.TheMovieDBApi.imageBaseURL
        
        if let posterPath = movie.posterPath {
            let urlString = baseURL + posterPath
            movieImageURL = URL(string: urlString)
        } else {
            movieImageURL = nil
        }
        
        self.favorite = favorite
    }
}
