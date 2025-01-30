//
//  NetworkManager.swift
//  FilmFlow
//
//  Created by İrem Onart on 27.01.2025.
//

import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "http://www.omdbapi.com/"
    private let apiKey = "3359e7ed"
    
    private init() {}
    
    func request<T: Decodable>(
        parameters: [String: String] = [:],
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        var parametersWithAPIKey = parameters
        parametersWithAPIKey["apikey"] = apiKey
        
        let url = baseURL
        
        AF.request(url, parameters: parametersWithAPIKey)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let decodedResponse):
                    completion(.success(decodedResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingFailed
}
