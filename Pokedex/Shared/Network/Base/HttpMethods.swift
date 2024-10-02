//
//  HttpMethods.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

enum HttpMethods {
    case get
    case post
    case put
    case delete
    case patch

    var methodName: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        case .put: return "PUT"
        case .delete: return "DELETE"
        case .patch: return "PATCH"
        }
    }
}
