//
//  PokemonCardCoordinator.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import Foundation

class PokemonCardCoordinator: BaseCoordinator<PokemonCardView<PokemonCardViewModel>> {
    private let pokemonData: PokemonListResponse.PokemonData
    private let services: HomeServicesProtocol

    init(pokemonData: PokemonListResponse.PokemonData, services: HomeServicesProtocol = HomeServices()) {
        self.pokemonData = pokemonData
        self.services = services
    }

    override func start() -> PokemonCardView<PokemonCardViewModel> {
        let viewModel = PokemonCardViewModel(coordinator: self, pokemonData: pokemonData, services: services)
        return PokemonCardView(viewModel: viewModel)
    }
}
