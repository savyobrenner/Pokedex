//
//  PokemonCardCoordinator.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import Foundation

class PokemonCardCoordinator {
    private let pokemonData: PokemonListResponse.PokemonData
    private let pokemon: Pokemon?
    private let action: (Pokemon) -> Void

    init(pokemonData: PokemonListResponse.PokemonData, pokemon: Pokemon? = nil, action: @escaping (Pokemon) -> Void) {
        self.pokemonData = pokemonData
        self.pokemon = pokemon
        self.action = action
    }

    func start() -> PokemonCardView<PokemonCardViewModel> {
        let services = HomeServices()

        let viewModel = PokemonCardViewModel(
            coordinator: self,
            pokemonData: pokemonData,
            pokemon: pokemon,
            services: services,
            action: action
        )
        
        return PokemonCardView(viewModel: viewModel)
    }
}
