//
//  HomeViewModelProtocol.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import Foundation

protocol HomeViewModelProtocol: ViewModelProtocol {
    var pokemons: [PokemonListResponse.PokemonData] { get }
    var pokemonDetails: [String: Pokemon] { get }
    var searchText: String { get set }
    var isLoading: Bool { get set }
    var isSearching: Bool { get set }
    var selectedType: String { get set }
    var availableTypes: [String] { get set }

    func onLoad()
    func loadMorePokemons()
    func searchPokemon(by nameOrId: String) async
}
