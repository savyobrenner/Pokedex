//
//  HomeServicesProtocol.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import Foundation

protocol HomeServicesProtocol {
    func loadPokemons(limit: Int, offset: Int) async throws -> PokemonListResponse
    func loadPokemons(from url: URL) async throws -> PokemonListResponse
    func searchPokemon(nameOrId: String) async throws -> Pokemon
    func loadPokemonDetails(from url: URL) async throws -> Pokemon
    func loadTypes() async throws -> TypeListResponse
    func loadPokemonsByType(_ type: String) async throws -> [PokemonListResponse.PokemonData]
}
