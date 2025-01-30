//
//  HomePageViewModel.swift
//  FilmFlow
//
//  Created by İrem Onart on 27.01.2025.
//

import Foundation

class HomePageViewModel: HomePageViewModelProtocol {
    var changeHandler: ((HomePageViewModelChange) -> Void)?
    
    var films: [Film] = []
    var filteredFilms: [Film] = []
    var numofFilms: Int = 0
    
    func fetchFilm(filmName: String) {
        self.emit(change: .startLoading)
        NetworkManager.shared.request(
            parameters: ["s": filmName],
            responseType: FilmResponse.self
        ) { result in
            self.emit(change: .endLoading)
            switch result {
            case .success(let filmResponse):
                if let films = filmResponse.search, !films.isEmpty {
                    print("Fetched Films: \(films)")
                    self.emit(change: .success)
                    self.films = films
                    self.filteredFilms = films
                    self.numofFilms = films.count
                    self.emit(change: .hideFilmFound)
                } else {
                    print("No films found")
                    self.emit(change: .didError("No films found", "Warning!"))
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                self.emit(change: .didError("Servis hatası: \(error.localizedDescription)", ""))
            }
        }
    }

    func indexOfFilms(at indexPath: IndexPath) -> Film {
        return filteredFilms[indexPath.row]
    }
    
    private func emit(change: HomePageViewModelChange) {
        changeHandler?(change)
    }
}
