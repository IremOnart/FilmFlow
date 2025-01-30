//
//  SplashViewModel.swift
//  FilmFlow
//
//  Created by İrem Onart on 26.01.2025.
//

import Foundation
import Firebase
import Alamofire

class SplashViewModel: SplashViewModelProtocol {
    var changeHandler: ((SplashViewModelChange) -> Void)?
    
    func checkInternetConnection() {
        let reachabilityManager = NetworkReachabilityManager()
        reachabilityManager?.startListening { status in
            switch status {
            case .reachable:
                self.emit(change: .connectionSuccess)
            case .notReachable, .unknown:
                self.emit(change: .didError("Internet connection not available."))
            }
        }
    }
    
    func fetchRemoteConfig() {
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings

        remoteConfig.fetchAndActivate { status, error in
            if status != .error {
                let splashText = remoteConfig.configValue(forKey: "splash_text").stringValue
                self.emit(change: .remoteConfigSuccess(splashText))
            }
        }
    }
    
    private func emit(change: SplashViewModelChange) {
        changeHandler?(change)
    }
}
