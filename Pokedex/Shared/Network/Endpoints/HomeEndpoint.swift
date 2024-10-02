//
//  HomeEndpoint.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import Foundation

enum HomeEndpoint: Endpoint {
    case loadPokemons(limit: Int, offset: Int)
    case searchPokemon(nameOrId: String)

    var path: String {
        switch self {
        case .loadPokemons(let limit, let offset):
            return "pokemon?limit=\(limit)&offset=\(offset)"
        case .searchPokemon(let nameOrId):
            return "pokemon/\(nameOrId)"
        }
    }

    var request: HttpMethods {
        switch self {
        case .loadPokemons,
             .searchPokemon:
            return .get
        }
    }

    var requestSpecificHeaders: [String : String] {
        return [:]
    }

    var queryParameters: [URLQueryItem] {
        return []
    }
}
