//
//  MovieDetailsRequestModel.swift
//  Movies
//
//  Created by Daniel Roszczyk on 22/12/2024.
//

struct MovieDetailsRequestModel {
    let movieId: Int
    let appendToResponse: String?
    let language: String?
    
    init(movieId: Int,
         appendToResponse: String? = nil,
         language: String? = nil) {
        self.movieId = movieId
        self.appendToResponse = appendToResponse
        self.language = language
    }
}
