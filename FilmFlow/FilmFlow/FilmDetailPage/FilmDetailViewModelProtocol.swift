//
//  FilmDetailViewModelProtocol.swift
//  FilmFlow
//
//  Created by İrem Onart on 28.01.2025.
//

import Foundation

enum FilmDetailViewModelChange {
    case startLoading
    case endLoading
    case didError(String)
    case fetchSuccess
}

protocol FilmDetailViewModelProtocol {
    var changeHandler: ((FilmDetailViewModelChange) -> Void)? { get set }
    var film: Film? { get set }
    var filmDetail: FilmDetail? { get set }
    
    func fetchFilmDetail()
}
