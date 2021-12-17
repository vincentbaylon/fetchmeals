//
//  NetworkManager.swift
//  FetchMeal
//
//  Created by Vince Baylon on 12/16/21.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let baseURL = "https://www.themealdb.com/api/json/v1/1/"
    
    private init() {}
    
    func getCategories(completed: @escaping (Result<EntireCategory, ErrorMessage>) -> Void) {
        let endpoint = baseURL + "categories.php"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let categories = try decoder.decode(EntireCategory.self, from: data)
                completed(.success(categories))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
//    func getMeals(for category: String, completed: @escaping ([Category]?, String?) -> Void) {
//        let endpoint = baseURL + "filter.php?c=\(category)"
//    }
//    
//    func getDetails(for meal: String) {
//        
//    }
}
