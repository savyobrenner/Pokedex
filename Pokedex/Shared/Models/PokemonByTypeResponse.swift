//
//  PokemonByTypeResponse.swift
//  Pokedex
//
//  Created by Savyo Brenner on 03/10/24.
//

struct PokemonByTypeResponse: Codable {
    let pokemons: [PokemonListResponse.PokemonData]

    private enum CodingKeys: String, CodingKey {
        case pokemons = "pokemon"
    }

    struct Wrapper: Codable {
        let pokemon: PokemonListResponse.PokemonData
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let wrappers = try container.decode([Wrapper].self, forKey: .pokemons)
        self.pokemons = wrappers.map { $0.pokemon }
    }
}
