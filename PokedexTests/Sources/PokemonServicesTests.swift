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

        let mockPokemonList = """
        {
        "count": 1,
        "next": null,
        "results": [
                { 
                    "name": "pikachu",
                    "url": "https://pokeapi.co/api/v2/pokemon/25/" 
                }
            ]
        }
        """
        mockNetwork.mockData = mockPokemonList.data(using: .utf8)

        services = PokemonServices(network: mockNetwork)
    }

    override func tearDown() {
        mockNetwork = nil
        services = nil
        super.tearDown()
    }

    func testLoadPokemons() {
        let expectation = self.expectation(description: "Load Pokemons")

        Task {
            do {
                let response = try await services.loadPokemons(limit: 20, offset: 0)
                XCTAssertEqual(response.results.count, 1)
                XCTAssertEqual(response.results.first?.name, "pikachu")
                expectation.fulfill()
            } catch {
                XCTFail("Failed with error: \(error)")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 2.0)
    }

    func testSearchPokemon() {
        let expectation = self.expectation(description: "Search Pokemon")

        let mockPokemon = """
        {
            "id": 25,
            "name": "pikachu",
            "height": 4,
            "weight": 60,
            "sprites": {
                "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"
            },
            "types": [
                {
                    "slot": 1,
                    "type": {
                        "name": "electric"
                    }
                }
            ]
        }
        """
        mockNetwork.mockData = mockPokemon.data(using: .utf8)

        Task {
            do {
                let pokemon = try await services.searchPokemon(nameOrId: "25")
                XCTAssertEqual(pokemon.name, "pikachu")
                expectation.fulfill()
            } catch {
                XCTFail("Failed with error: \(error)")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 2.0)
    }
}
