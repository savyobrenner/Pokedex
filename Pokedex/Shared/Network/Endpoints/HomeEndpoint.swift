//
//  HomeEndpoint.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import Foundation

enum HomeEndpoint {
    case loadHome
    case loadPokemons(limit: Int, offset: Int)
    case searchPokemon(nameOrId: String)
    case loadPokemonsByType(type: String)
}

extension HomeEndpoint: Endpoint {
    var path: String {
        switch self {
        case .loadHome:
            return ""
        case .loadPokemons(let limit, let offset):
            return "pokemon?limit=\(limit)&offset=\(offset)"
        case .searchPokemon(let nameOrId):
            return "pokemon/\(nameOrId)"
        case .loadPokemonsByType(let type):
            return "type/\(type)"
        }
    }

    var request: HttpMethods {
        switch self {
        case .loadHome, .loadPokemons,
             .searchPokemon,
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
