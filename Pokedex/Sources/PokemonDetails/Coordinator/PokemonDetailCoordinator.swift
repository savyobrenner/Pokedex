//
//  PokemonDetailCoordinator.swift
//  Pokedex
//
//  Created by Savyo Brenner on 03/10/24.
//

import SwiftUI

class PokemonDetailCoordinator {
    private let pokemon: Pokemon
    private let appCoordinator: AppCoordinator

    init(pokemon: Pokemon, appCoordinator: AppCoordinator) {
        self.pokemon = pokemon
        self.appCoordinator = appCoordinator
    }

    func start() -> AnyView {
        let viewModel = PokemonDetailViewModel(coordinator: self, pokemon: pokemon)
        return AnyView(PokemonDetailView(viewModel: viewModel))
    }
}
