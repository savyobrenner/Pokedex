//
//  PokemonCardViewModelProtocol.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import SwiftUI

protocol PokemonCardViewModelProtocol: ObservableObject {
    var pokemonDetails: Pokemon? { get }
    func loadPokemonDetails()
    func onTapGesture()
}
