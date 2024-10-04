//
//  MockPokemonServices.swift
//  Pokedex
//
//  Created by Savyo Brenner on 04/10/24.
//

import Foundation
@testable import Pokedex

class MockPokemonServices: PokemonServicesProtocol {
    var shouldFail = false

    // Mock data
    private let mockPokemonListResponse = PokemonListResponse(
        count: 1,
        next: URL(string: "nscreen://example.com")!,
        results: [
            PokemonListResponse.PokemonData(name: "pikachu", url: URL(string: "nscreen://example.com")!)
        ]
    )

    private let mockPokemon = Pokemon(
        abilities: [],
        baseExperience: nil,
        height: nil,
        id: 25,
        name: "pikachu",
        species: nil,
        images: nil,
        stats: [],
        types: nil,
        weight: nil
    )

    func loadPokemons(limit: Int, offset: Int) async throws -> PokemonListResponse {
        if shouldFail {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No mock data provided"])
        }
        return mockPokemonListResponse
    }

    func loadPokemons(from url: URL) async throws -> PokemonListResponse {
        if shouldFail {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No mock data provided"])
        }
        return mockPokemonListResponse
    }

    func searchPokemon(nameOrId: String) async throws -> Pokemon {
        if shouldFail || nameOrId == "unknown" {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No mock data provided"])
        }
        
        return mockPokemon
    }

    func loadPokemonDetails(from url: URL) async throws -> Pokemon {
        if shouldFail {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No mock data provided"])
        }
        return mockPokemon
    }

    func loadTypes() async throws -> TypeListResponse {
        if shouldFail {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No mock data provided"])
        }
        return TypeListResponse(count: 0, next: nil, results: [TypeListResponse.TypeData(name: "electric", url: "")])
    }

    func loadPokemonsByType(_ type: String) async throws -> [PokemonListResponse.PokemonData] {
        if shouldFail {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No mock data provided"])
        }
        return mockPokemonListResponse.results
    }
}
