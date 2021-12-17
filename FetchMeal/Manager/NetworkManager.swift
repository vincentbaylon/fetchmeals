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
    
    
    
//    func getMeals(for category: String, completed: @escaping ([Category]?, String?) -> Void) {
//        let endpoint = baseURL + "filter.php?c=\(category)"
//    }
//    
//    func getDetails(for meal: String) {
//        
//    }
}
