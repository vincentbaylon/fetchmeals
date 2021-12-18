//
//  Category.swift
//  FetchMeal
//
//  Created by Vince Baylon on 12/16/21.
//

import Foundation

struct EntireCategory: Codable {
    let categories: [Category]
}

struct Category: Codable, Hashable {
    var idCategory: String
    var strCategory: String
    var strCategoryThumb: String
    var strCategoryDescription: String
}
