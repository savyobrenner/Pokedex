//
//  PokemonCardCoordinator.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import Foundation

class PokemonCardCoordinator: BaseCoordinator<PokemonCardView<PokemonCardViewModel>> {
    private let pokemonData: PokemonListResponse.PokemonData
    private let pokemon: Pokemon?

    init(pokemonData: PokemonListResponse.PokemonData, pokemon: Pokemon? = nil) {
        self.pokemonData = pokemonData
        self.pokemon = pokemon
    }

    override func start() -> PokemonCardView<PokemonCardViewModel> {
        let services = HomeServices()
        let viewModel = PokemonCardViewModel(
            coordinator: self,
            pokemonData: pokemonData,
            pokemon: pokemon,
            services: services
        )
        return PokemonCardView(viewModel: viewModel)
    }
}
