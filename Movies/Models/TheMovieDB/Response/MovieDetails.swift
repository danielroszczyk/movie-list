//
//  MovieDetails.swift
//  Movies
//
//  Created by Daniel Roszczyk on 19/12/2024.
//

struct MovieDetails: Decodable {
    let adult: Bool?
    let backdropPath: String?
    let belongsToCollection: String?
    let budget: Int?
    let genres: [Genre]
    let homepage: String?
    let id: Int
    let imdbId: String?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    let releaseDate: String?
    let revenue: Int?
    let runtime: Int?
    let spokenLanguages: [SpokenLanguage]
    let status: String?
    let tagline: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
}
