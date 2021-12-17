//
//  ErrorMessage.swift
//  FetchMeal
//
//  Created by Vince Baylon on 12/16/21.
//

import Foundation

enum ErrorMessage: String, Error {
    case invalidUrl = "Error fetching data. Please try again."
    case unableToComplete = "Unable to complete request. Please check your connection."
    case invalidResponse = "Invalid response from server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}
