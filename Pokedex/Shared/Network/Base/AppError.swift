//
//  AppError.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import Foundation

enum AppError: Error {
    case invalidURL
    case invalidResponse
    case statusCode(Int)
    case urlError(URLError)
    case unknown
}
