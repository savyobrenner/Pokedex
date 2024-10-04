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
    
    func testLoadPokemons() async {
        viewModel.onLoad()
        
        XCTAssertEqual(viewModel.pokemons.count, 1)
        XCTAssertEqual(viewModel.pokemons.first?.name, "pikachu")
    }
    
    func testLoadMorePokemons() async {
        viewModel.onLoad()
        viewModel.loadMorePokemons()
        
        XCTAssertEqual(viewModel.pokemons.count, 2)
    }
    
    func testSearchPokemon() async {
        await viewModel.searchPokemon(by: "25")
        
        XCTAssertEqual(viewModel.pokemons.count, 1)
        XCTAssertEqual(viewModel.pokemons.first?.name, "pikachu")
    }
    
    func testSearchNoResult() async {
        mockServices.shouldFail = true
        await viewModel.searchPokemon(by: "unknown")

        XCTAssertTrue(viewModel.pokemons.isEmpty)
    }
    
    func testHandleSelectionChange() async {
        viewModel.selectedType = "electric"
        await viewModel.searchPokemonByType("electric")
        
        XCTAssertEqual(viewModel.pokemons.count, 1)
        XCTAssertEqual(viewModel.pokemons.first?.name, "pikachu")
    }
}
