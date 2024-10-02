//
//  Endpoint.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import Foundation

protocol Endpoint {
    var url: URL? { get }
    var host: String { get }
    var version: String { get }
    var path: String { get }
    var requestSpecificHeaders: [String: String] { get }
    var request: HttpMethods { get }
    var queryParameters: [URLQueryItem] { get }
}

// MARK: - Default
extension Endpoint {
    var host: String { AppEnviroment.host }

    var version: String { AppEnviroment.defaultVersion }

    var url: URL? {
        .init(string: "\(host)/\(version)/\(path)/")
    }
}
