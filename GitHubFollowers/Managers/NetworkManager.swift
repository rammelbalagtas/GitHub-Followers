//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Rammel on 2022-06-23.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/users/"
    
    private init() {}
    
    func getFollowers(userName: String, page: Int, completion: @escaping (Result<[Follower], GFError>) -> Void) {
        let endpoint = "\(baseURL)\(userName)/followers?per_page=100&page=\(page)"
        guard
            let url = URL(string: endpoint)
        else{
            completion(.failure(GFError.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url)
        { data, response, error in
            if let _ = error {
                completion(.failure(GFError.unableToComplete))
                return
            }
            
            guard
                let response = response as? HTTPURLResponse, response.statusCode == 200
            else {
                completion(.failure(GFError.invalidResponse))
                return
            }
            
            guard
                let data = data
            else {
                completion(.failure(GFError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completion(.success(followers))
            } catch  {
                completion(.failure(GFError.invalidData))
            }
            
        }
        
        task.resume()
        
    }
}
