//
//  MoviesResponse.swift
//  Movies
//
//  Created by Daniel Roszczyk on 19/12/2024.
//

struct MoviesResponse: Decodable {
    let dates: MovieDates
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
}
