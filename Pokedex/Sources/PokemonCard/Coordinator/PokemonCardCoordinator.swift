//
//  PokemonCardCoordinator.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import Foundation

class PokemonCardCoordinator: BaseCoordinator<PokemonCardView<PokemonCardViewModel>> {
    private let pokemonData: PokemonListResponse.PokemonData

    init(pokemonData: PokemonListResponse.PokemonData) {
        self.pokemonData = pokemonData
    }

    override func start() -> PokemonCardView<PokemonCardViewModel> {
        let services = HomeServices()
        let viewModel = PokemonCardViewModel(coordinator: self, pokemonData: pokemonData, services: services)
        return PokemonCardView(viewModel: viewModel)
    }
}
