//
//  Movie.swift
//  Movie
//
//  Created by Marius Stefanita Jianu on 28.04.2024.
//

import Foundation

struct Movie: Codable, Identifiable, Equatable {
    let id: Int
    let voteCount: Int
    let video: Bool
    let voteAverage: Double
    let title: String
    let popularity: Double
    let posterPath: String
    let originalLanguage: String
    let originalTitle: String
    let genreIds: [Int]
    let backdropPath: String
    let adult: Bool
    let overview: String
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
        case title
        case popularity
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIds = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult
        case overview
        case releaseDate = "release_date"
    }
    
    var fullPosterURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }

}

struct MoviesResponse: Decodable {
    let results: [Movie]
}


