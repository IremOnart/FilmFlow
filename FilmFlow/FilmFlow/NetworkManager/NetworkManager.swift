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
    
    private var apiKey: String? {
        if let path = Bundle.main.path(forResource: "PropertyList", ofType: "plist"),
           let xml = FileManager.default.contents(atPath: path),
           let plist = try? PropertyListSerialization.propertyList(from: xml, options: .mutableContainers, format: nil),
           let dict = plist as? [String: Any],
           let key = dict["API_KEY"] as? String {
            return key
        }
        return nil
    }
    
    private init() {}
    
    func request<T: Decodable>(
        parameters: [String: String] = [:],
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let apiKey = apiKey else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
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
