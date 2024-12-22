//
//  SearchMovieRequestModel.swift
//  Movies
//
//  Created by Daniel Roszczyk on 22/12/2024.
//

struct SearchMovieRequestModel {
    let query: String
    let includeAdult: Bool?
    let language: String?
    let primaryReleaseYear: String?
    let page: Int?
    let region: String?
    let year: String?
    
    init(query: String,
         includeAdult: Bool? = nil,
         language: String? = nil,
         primaryReleaseYear: String? = nil,
         page: Int? = nil,
         region: String? = nil,
         year: String? = nil) {
        self.query = query
        self.includeAdult = includeAdult
        self.language = language
        self.primaryReleaseYear = primaryReleaseYear
        self.page = page
        self.region = region
        self.year = year
    }
}
