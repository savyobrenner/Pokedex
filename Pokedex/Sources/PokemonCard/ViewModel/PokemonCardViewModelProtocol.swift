//
//  PokemonCardViewModelProtocol.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

protocol PokemonCardViewModelProtocol: ViewModelProtocol {
    var pokemonDetails: Pokemon? { get }
    func loadPokemonDetails()
}
