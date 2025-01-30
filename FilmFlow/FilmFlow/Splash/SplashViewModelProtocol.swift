//
//  SplashViewModelProtocol.swift
//  FilmFlow
//
//  Created by İrem Onart on 26.01.2025.
//

import Foundation

enum SplashViewModelChange {
    case didError(String)
    case connectionSuccess
    case remoteConfigSuccess(String)
}

protocol SplashViewModelProtocol {
    var changeHandler: ((SplashViewModelChange) -> Void)? { get set }
  
    
    func checkInternetConnection()
    func fetchRemoteConfig()
}
