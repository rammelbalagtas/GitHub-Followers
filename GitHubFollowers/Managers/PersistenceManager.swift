//
//  PersistenceManager.swift
//  GitHubFollowers
//
//  Created by Rammel on 2022-07-04.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistentManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func update(with favorite: Follower, actionType: PersistenceActionType, completion: @escaping (GFError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(var favorites):
                switch actionType {
                case .add:
                    guard !favorites.contains(where: { $0.login == favorite.login }) else {
                        completion(GFError.alreadyInFavorites)
                        return
                    }
                    favorites.append(favorite)
                case .remove:
                    favorites.removeAll{ $0.login == favorite.login }
                }
                completion(saveFavorites(favorites: favorites))
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else
        {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch  {
            completed(.failure(GFError.unableToFavorite))
        }
    }
    
    static func saveFavorites(favorites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
        } catch {
            return GFError.unableToFavorite
        }
        return nil
    }
}
