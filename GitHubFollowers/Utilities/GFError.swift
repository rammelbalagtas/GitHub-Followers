//
//  GFError.swift
//  GitHubFollowers
//
//  Created by Rammel on 2022-06-24.
//

import Foundation

enum GFError: String, Error {
    case invalidRequest = "User created an invalid request. Please try again"
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from server. Please try again"
    case invalidData = "Data received from server was invalid. Please try again"
}
