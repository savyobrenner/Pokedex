//
//  PokemonServicesTests.swift
//  Pokedex
//
//  Created by Savyo Brenner on 04/10/24.
//

import XCTest
@testable import Pokedex

final class PokemonServicesTests: XCTestCase {
    private var mockNetwork: MockNetworkClient!
    private var services: PokemonServices!

    override func setUp() {
        super.setUp()
        mockNetwork = MockNetworkClient()
        services = PokemonServices(network: mockNetwork)
    }

    override func tearDown() {
        mockNetwork = nil
        services = nil
        super.tearDown()
    }

    func test_loadPokemons_returnsPokemons() async throws {
        let response = try await services.loadPokemons(limit: 20, offset: 0)
        XCTAssertEqual(response.results.count, 1)
        XCTAssertEqual(response.results.first?.name, "pikachu")
    }

    func test_searchPokemon_returnsPokemon() async throws {
        let pokemon = try await services.searchPokemon(nameOrId: "25")
        XCTAssertEqual(pokemon.name, "pikachu")
    }
}
