//
//  MockPokemonServices.swift
//  Pokedex
//
//  Created by Savyo Brenner on 04/10/24.
//

import Foundation
@testable import Pokedex

final class MockPokemonServices: PokemonServicesProtocol {
    var shouldFail = false

    func loadPokemons(limit: Int, offset: Int) async throws -> PokemonListResponse {
        if shouldFail {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to load pokemons"])
        }

        return PokemonListResponse(
            count: 1,
            next: nil,
            results: [PokemonListResponse.PokemonData(name: "pikachu", url: URL(string: "https://pokeapi.co/api/v2/pokemon/25/")!)]
        )
    }

    func loadPokemons(from url: URL) async throws -> PokemonListResponse {
        return try await loadPokemons(limit: 20, offset: 0)
    }

    func searchPokemon(nameOrId: String) async throws -> Pokemon {
        if shouldFail {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to find pokemon"])
        }

        return Pokemon(
            abilities: [.init(ability: nil, isHidden: nil, slot: nil)],
            baseExperience: nil,
            height: nil,
            id: 25,
            name: "pikachu",
            species: nil,
            images: nil,
            stats: nil,
            types: nil,
            weight: nil
        )
    }

    func loadPokemonDetails(from url: URL) async throws -> Pokemon {
        return try await searchPokemon(nameOrId: "25")
    }

    func loadTypes() async throws -> TypeListResponse {
        return TypeListResponse(
            count: 1,
            next: nil,
            results: [.init(name: "electric", url: "https://pokeapi.co/api/v2/type/13/")]
        )
    }

    func loadPokemonsByType(_ type: String) async throws -> [PokemonListResponse.PokemonData] {
        return [PokemonListResponse.PokemonData(name: "pikachu", url: URL(string: "https://pokeapi.co/api/v2/pokemon/25/")!)]
    }
}
