//
//  Movie.swift
//  Movies
//
//  Created by Daniel Roszczyk on 19/12/2024.
//

struct Movie: Decodable {
    let adult: Bool?
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
}
