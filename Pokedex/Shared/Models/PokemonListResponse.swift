//
//  PokemonListResponse.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import Foundation

struct PokemonListResponse: Codable {
    let count: Int
    let next: URL?
    let results: [PokemonData]
}

extension PokemonListResponse {
    struct PokemonData: Codable, Equatable {
        let name: String
        let url: URL
    }
}
