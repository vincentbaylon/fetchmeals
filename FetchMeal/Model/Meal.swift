//
//  Meal.swift
//  FetchMeal
//
//  Created by Vince Baylon on 12/16/21.
//

import Foundation

struct EntireMeal: Codable {
    let meals: [Meal]
}

struct Meal: Codable, Hashable {
    var strMeal: String
    var strMealThumb: String
    var idMeal: String
}

struct EntireMealDetails: Decodable {
    let meals: [MealDetails]
}

struct MealDetails: Decodable {
    private enum CodingKeys: String, CodingKey {
        case strIngredient1 = "strIngredient1"
        case strIngredient2 = "strIngredient2"
        case strIngredient3 = "strIngredient3"
        case strIngredient4 = "strIngredient4"
        case strIngredient5 = "strIngredient5"
        case strIngredient6 = "strIngredient6"
        case strIngredient7 = "strIngredient7"
        case strIngredient8 = "strIngredient8"
        case strIngredient9 = "strIngredient9"
        case strIngredient10 = "strIngredient10"
        case strIngredient11 = "strIngredient11"
        case strIngredient12 = "strIngredient12"
        case strIngredient13 = "strIngredient13"
        case strIngredient14 = "strIngredient14"
        case strIngredient15 = "strIngredient15"
        case strIngredient16 = "strIngredient16"
        case strIngredient17 = "strIngredient17"
        case strIngredient18 = "strIngredient18"
        case strIngredient19 = "strIngredient19"
        case strIngredient20 = "strIngredient20"
        case strMeasure1 = "strMeasure1"
        case strMeasure2 = "strMeasure2"
        case strMeasure3 = "strMeasure3"
        case strMeasure4 = "strMeasure4"
        case strMeasure5 = "strMeasure5"
        case strMeasure6 = "strMeasure6"
        case strMeasure7 = "strMeasure7"
        case strMeasure8 = "strMeasure8"
        case strMeasure9 = "strMeasure9"
        case strMeasure10 = "strMeasure10"
        case strMeasure11 = "strMeasure11"
        case strMeasure12 = "strMeasure12"
        case strMeasure13 = "strMeasure13"
        case strMeasure14 = "strMeasure14"
        case strMeasure15 = "strMeasure15"
        case strMeasure16 = "strMeasure16"
        case strMeasure17 = "strMeasure17"
        case strMeasure18 = "strMeasure18"
        case strMeasure19 = "strMeasure19"
        case strMeasure20 = "strMeasure20"
        case id = "idMeal"
        case name = "strMeal"
        case category = "strCategory"
        case area = "strArea"
        case instructions = "strInstructions"
        case image = "strMealThumb"
    }

    let id: String
    let name: String
    let category: String
    let area: String
    let instructions: String
    let image: String
    var ingredients: [String]
    var measurements: [String]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.category = try container.decode(String.self, forKey: .category)
        self.area = try container.decode(String.self, forKey: .area)
        self.instructions = try container.decode(String.self, forKey: .instructions)
        self.image = try container.decode(String.self, forKey: .image)
        
        self.ingredients = []
        self.measurements = []
        
        for index in 1...20 {
            let ingredientString = "strIngredient\(index)"
            let measureString = "strMeasure\(index)"
            
            guard let ingredientCodingKey = CodingKeys(rawValue: ingredientString) else { return }
            guard let measureCodingKey = CodingKeys(rawValue: measureString) else { return }
            
            let ingredient = try container.decode(String.self, forKey: ingredientCodingKey)
            let measure = try container.decode(String.self, forKey: measureCodingKey)
            
            if ingredient.isEmpty && measure.isEmpty || ingredient == " " || measure == " " {
                return
            } else {
                self.ingredients.append(ingredient)
                self.measurements.append(measure)
            }
        }
    }
}
