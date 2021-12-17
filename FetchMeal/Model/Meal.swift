//
//  Meal.swift
//  FetchMeal
//
//  Created by Vince Baylon on 12/16/21.
//

import Foundation

struct Meal: Codable {
    var strMeal: String
    var strInstructions: String
    var strMealThumb: String
    var idMeal: String
    var ingredient: Ingredient
}
