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

    func onLoad()
    func loadMorePokemons() async
    func searchPokemon(by nameOrId: String) async
    func loadPokemonDetails(for url: URL) async
}
