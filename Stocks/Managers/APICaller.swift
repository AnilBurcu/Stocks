//
//  APICaller.swift
//  Stocks
//
//  Created by Anıl Bürcü on 2.10.2023.
//

import Foundation

final class APICaller {
    
    static let shared = APICaller()
    
    private struct Constants {
        static let apiKey = "ckd9b01r01qg61btsmjgckd9b01r01qg61btsmk0"
        static let secretKey = "ckd9b01r01qg61btsml0"
        static let baseUrl = "https://finnhub.io/api/v1/"
        
    }
    
    private init(){}
    
    //MARK: - Public
    
    public func search(
        query: String,
        completion: @escaping (Result<SearchResponse,Error>) -> Void
    ) {
        //Boşluk bırakınce url request arama yapmıyor
        guard let safeQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        request(
            url: url(
                for: .search,
                queryParams: ["q": safeQuery]),
            expecting: SearchResponse.self,
            completion: completion
        )
        
    }
    
    //MARK: - Get Stock Info
    
    //MARK: - Search Stocks
    
    //MARK: - Private
    
    private enum Endpoint: String {
        case search
    }
    private enum APIError: Error {
        case noDataReturned
        case invalidUrl
    }
    
    //bu fonk bize çıkışında ?url yaratıyor
    private func url(for endpoint: Endpoint,
                     queryParams: [String:String] = [:])-> URL? {
        
        var urlString = Constants.baseUrl + endpoint.rawValue
        
        var queryItems = [URLQueryItem]()
        
        for (key,value) in queryParams {
            queryItems.append(.init(name: key, value: value))
        }
        // Add any parameters
        
        // Add token
        queryItems.append(.init(name: "token", value: Constants.apiKey))
        
        // Convert query items to suffix string
        
        
        urlString += "?" + queryItems.map { "\($0.name)=\($0.value ?? "")" }.joined(separator: "&")
        
            
        print("\n\(urlString)\n")
        
        return URL(string: urlString)
    }
    
    /// Perform api call
    /// - Parameters:
    ///   - url: URL to hit
    ///   - expecting: Type we expect to decode data to
    ///   - completion: Result callback
    private func request<T: Codable>(
        url: URL?,
        expecting: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = url else {
            // Invalid url
            completion(.failure(APIError.invalidUrl))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(APIError.noDataReturned))
                }
                return
            }

            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
