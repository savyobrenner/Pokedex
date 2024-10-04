//
//  HomeViewModelTests.swift
//  Pokedex
//
//  Created by Savyo Brenner on 04/10/24.
//

import XCTest
@testable import Pokedex

final class HomeViewModelTests: XCTestCase {
    private var mockServices: MockPokemonServices!
    private var viewModel: HomeViewModel!

    override func setUp() {
        super.setUp()
        mockServices = MockPokemonServices()
        viewModel = HomeViewModel(coordinator: HomeCoordinator(appCoordinator: AppCoordinator()), services: mockServices)
    }

    override func tearDown() {
        mockServices = nil
        viewModel = nil
        super.tearDown()
    }

    func testLoadPokemons() {
        let expectation = self.expectation(description: "Load Pokemons")

        viewModel.onLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(self.viewModel.pokemons.count, 1)
            XCTAssertEqual(self.viewModel.pokemons.first?.name, "pikachu")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

    func testLoadMorePokemons() {
        let expectation = self.expectation(description: "Load More Pokemons")

        viewModel.onLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.viewModel.loadMorePokemons()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                XCTAssertEqual(self.viewModel.pokemons.count, 2)
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 3.0)
    }

    func testSearchPokemon() {
        let expectation = self.expectation(description: "Search Pokemon")

        Task {
            await viewModel.searchPokemon(by: "25")

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                XCTAssertEqual(self.viewModel.pokemons.count, 1)
                XCTAssertEqual(self.viewModel.pokemons.first?.name, "pikachu")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 2.0)
    }

    func testSearchNoResult() {
        let expectation = self.expectation(description: "Search No Result")

        mockServices.shouldFail = true
        Task {
            await viewModel.searchPokemon(by: "unknown")
            DispatchQueue.main.async {
                XCTAssertTrue(self.viewModel.pokemons.isEmpty)
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 2.0)
    }

    func testHandleSelectionChange() {
        let expectation = self.expectation(description: "Handle Selection Change")

        viewModel.selectedType = "electric"

        Task {
            await viewModel.searchPokemonByType("electric")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                XCTAssertEqual(self.viewModel.pokemons.count, 1)
                XCTAssertEqual(self.viewModel.pokemons.first?.name, "pikachu")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 2.0)
    }
}
