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
    
    init?(title: String?, movieImageURL: URL?, favorite: UIImage?) {
        guard let title else { return nil }
        self.title = title
        self.movieImageURL = movieImageURL
        self.favorite = favorite
    }
}
