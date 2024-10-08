//
//  HomeViewModelProtocol.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import Foundation

protocol HomeViewModelProtocol: ObservableObject {
    var pokemons: [PokemonListResponse.PokemonData] { get }
    var pokemonDetails: [String: Pokemon] { get set }
    var searchText: String { get set }
    var isLoading: Bool { get set }
    var isSearching: Bool { get set }
    var selectedType: String { get set }
    var availableTypes: [String] { get set }
    var showingAlert: Bool { get set }
    var alertMessage: String { get set }

    func onLoad()
    func loadMorePokemons()
    func searchPokemon(by nameOrId: String) async
    func navigateToDetails(for pokemon: Pokemon)
    func loadPokemonDetails(for pokemonData: PokemonListResponse.PokemonData) async
}
