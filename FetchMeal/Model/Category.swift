//
//  Category.swift
//  FetchMeal
//
//  Created by Vince Baylon on 12/16/21.
//

import Foundation

struct EntireCategory: Codable {
    let categories: [Category]
    
    enum CodingKeys: String, CodingKey {
        case categories
    }
}

struct Category: Codable {
    var idCategory: String?
    var strCategory: String?
    var strCategoryThumb: String?
    var strCategoryDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case idCategory
        case strCategory
        case strCategoryThumb
        case strCategoryDescription
    }
}
