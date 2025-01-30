//
//  FilmDetailViewModel.swift
//  FilmFlow
//
//  Created by İrem Onart on 28.01.2025.
//

import Foundation
import FirebaseAnalytics

class FilmDetailViewModel: FilmDetailViewModelProtocol {
    
    var changeHandler: ((FilmDetailViewModelChange) -> Void)?
    
    var film: Film?
    var filmDetail: FilmDetail?
    
    func fetchFilmDetail() {
        self.emit(change: .startLoading)
        NetworkManager.shared.request(
            parameters: ["i": film?.imdbID ?? ""],
            responseType: FilmDetail.self
        ) { result in
            self.emit(change: .endLoading)
            switch result {
            case .success(let filmResponse):
                if filmResponse.response != nil {
                    print("Fetched filmDetail: \(filmResponse)")
                    self.filmDetail = filmResponse
                    self.emit(change: .fetchSuccess)
                } else {
                    print("No films found")
                    self.emit(change: .didError("Warning!"))
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                self.emit(change: .didError("Servis hatası: \(error.localizedDescription)"))
            }
        }
    }
    
    private func emit(change: FilmDetailViewModelChange) {
        changeHandler?(change)
    }
}
