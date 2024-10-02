//
//  HomeService.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import Foundation

final class HomeServices: HomeServicesProtocol {
    private let network: NetworkProtocol

    init(network: NetworkProtocol = NetworkClient()) {
        self.network = network
    }

    func loadPokemons(limit: Int, offset: Int) async throws -> PokemonListResponse {
        let endpoint = HomeEndpoint.loadPokemons(limit: limit, offset: offset)
        let response = try await network.sendRequest(endpoint: endpoint, responseModel: PokemonListResponse.self)
        return response
    }

    func loadPokemons(from url: URL) async throws -> PokemonListResponse {
        let response = try await network.sendRequest(url: url, responseModel: PokemonListResponse.self)
        return response
    }

    func searchPokemon(nameOrId: String) async throws -> Pokemon {
        let endpoint = HomeEndpoint.searchPokemon(nameOrId: nameOrId)
        let response = try await network.sendRequest(endpoint: endpoint, responseModel: Pokemon.self)
        return response
    }

    func loadPokemonDetails(from url: URL) async throws -> Pokemon {
        let response = try await network.sendRequest(url: url, responseModel: Pokemon.self)
        return response
    }
}
