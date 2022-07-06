//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Rammel on 2022-06-23.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()
    
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
    
    func getUserInfo(userName: String, completion: @escaping (Result<User, GFError>) -> Void) {
        let endpoint = "\(baseURL)\(userName)"
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
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(User.self, from: data)
                completion(.success(user))
            } catch  {
                completion(.failure(GFError.invalidData))
            }
            
        }
        
        task.resume()
        
    }
    
    func downloadImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: url)
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        guard
            let url = URL(string: url)
        else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url)
        { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data)
            else {
                completion(nil)
                return
            }
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        
        task.resume()
    }
}
