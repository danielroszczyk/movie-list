//
//  NowPlayingMoviesRequestModel.swift
//  Movies
//
//  Created by Daniel Roszczyk on 22/12/2024.
//

struct NowPlayingMoviesRequestModel {
    let language: String?
    let page: Int?
    let region: String?
    
    init(language: String? = nil,
         page: Int? = nil,
         region: String? = nil) {
        self.language = language
        self.page = page
        self.region = region
    }
}
