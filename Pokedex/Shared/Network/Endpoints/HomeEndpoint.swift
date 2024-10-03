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
    case loadTypes
    case loadPokemonsByType(String)

    var path: String {
        switch self {
        case let .loadPokemons(limit, offset):
            return "pokemon?limit=\(limit)&offset=\(offset)"
        case let .searchPokemon(nameOrId):
            return "pokemon/\(nameOrId)"
        case .loadTypes:
            return "type"
        case let .loadPokemonsByType(type):
            return "type/\(type)"
        }
    }
    
    var request: HttpMethods {
        switch self {
        case .loadPokemons,
                .searchPokemon,
                .loadTypes,
                .loadPokemonsByType:
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
