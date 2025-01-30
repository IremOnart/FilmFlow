//
//  HomePageViewModelProtocol.swift
//  FilmFlow
//
//  Created by İrem Onart on 27.01.2025.
//

import Foundation

enum HomePageViewModelChange {
    case startLoading
    case endLoading
    case didError(String,String)
    case success
    case hideFilmFound
}

protocol HomePageViewModelProtocol {
    var changeHandler: ((HomePageViewModelChange) -> Void)? { get set }
    var films: [Film] { get }
    var filteredFilms: [Film] { get }
    var numofFilms: Int { get }
  
    func fetchFilm(filmName: String)
    func indexOfFilms(at indexPath: IndexPath) -> Film
}
