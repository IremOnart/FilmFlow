//
//  FilmResponse.swift
//  FilmFlow
//
//  Created by İrem Onart on 27.01.2025.
//

import Foundation

struct FilmResponse: Codable {
    let search: [Film]?
    let totalResults: String?
    let response: String?

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}

struct Film: Codable {
    let title: String?
    let year: String?
    let imdbID: String?
    let type: String?
    let poster: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }
}


