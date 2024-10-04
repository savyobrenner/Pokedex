//
//  PokemonCardCoordinator.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import Foundation

class PokemonCardCoordinator {
    private let pokemonData: PokemonListResponse.PokemonData
    private let homeViewModel: HomeViewModel?
    private let action: (Pokemon) -> Void

    init(
        pokemonData: PokemonListResponse.PokemonData,
        homeViewModel: HomeViewModel?,
        action: @escaping (Pokemon) -> Void
    ) {
        self.pokemonData = pokemonData
        self.homeViewModel = homeViewModel
        self.action = action
    }

    func start() -> PokemonCardView<PokemonCardViewModel> {
        let viewModel = PokemonCardViewModel(
            coordinator: self,
            pokemonData: pokemonData,
            homeViewModel: homeViewModel,
            action: action
        )

        return PokemonCardView(viewModel: viewModel)
    }
}
