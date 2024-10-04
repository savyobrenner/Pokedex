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
    
    func test_onLoad_loadsPokemons() async {
        viewModel.onLoad()
        
        XCTAssertEqual(viewModel.pokemons.count, 1)
        XCTAssertEqual(viewModel.pokemons.first?.name, "pikachu")
    }
    
    func test_loadMorePokemons_appendsPokemons() async {
        viewModel.onLoad()
        viewModel.loadMorePokemons()
        
        XCTAssertEqual(viewModel.pokemons.count, 2)
    }
    
    func test_searchPokemon_findsPokemon() async {
        await viewModel.searchPokemon(by: "25")
        
        XCTAssertEqual(viewModel.pokemons.count, 1)
        XCTAssertEqual(viewModel.pokemons.first?.name, "pikachu")
    }
    
    func test_searchPokemon_noResults() async {
        mockServices.shouldFail = true
        await viewModel.searchPokemon(by: "unknown")

        XCTAssertTrue(viewModel.pokemons.isEmpty)
    }
    
    func test_handleTypeSelectionChange_resetsSelection() async {
        viewModel.selectedType = "electric"
        await viewModel.searchPokemonByType("electric")
        
        XCTAssertEqual(viewModel.pokemons.count, 1)
        XCTAssertEqual(viewModel.pokemons.first?.name, "pikachu")
    }
}
