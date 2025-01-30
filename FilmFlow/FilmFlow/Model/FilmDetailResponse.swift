//
//  FilmDetailResponse.swift
//  FilmFlow
//
//  Created by İrem Onart on 28.01.2025.
//

import Foundation

struct FilmDetail: Codable {
    let title: String?
    let year: String?
    let imdbRating: String?
    let type: String?
    let poster: String?
    let runtime: String?
    let genre: String?
    let director: String?
    let actors: String?
    let plot: String?
    let awards: String?
    let imdbVotes: String?
    let response: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbRating
        case type = "Type"
        case poster = "Poster"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case actors = "Actors"
        case plot = "Plot"
        case awards = "Awards"
        case imdbVotes = "imdbVotes"
        case response = "Response"
    }
}
