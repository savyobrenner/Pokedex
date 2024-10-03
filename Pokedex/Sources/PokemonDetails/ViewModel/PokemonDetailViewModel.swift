//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Savyo Brenner on 03/10/24.
//

import SwiftUI

class PokemonDetailViewModel: PokemonDetailViewModelProtocol {
    @Published
    var pokemon: Pokemon
    
    let coordinator: PokemonDetailCoordinator

    init(coordinator: PokemonDetailCoordinator, pokemon: Pokemon) {
        self.coordinator = coordinator
        self.pokemon = pokemon
    }

    var formattedStats: [String] {
        return pokemon.stats?.compactMap { stat in
            if let name = stat.stat?.name, let value = stat.baseStat {
                return "\(name.capitalized): \(value)"
            }
            return nil
        } ?? []
    }

    var types: [String] {
        return pokemon.types?.compactMap { $0.type?.name } ?? []
    }

    func onTypeSelected(_ type: String) {
//        coordinator.navigateToPokemonType(type)
    }
}
