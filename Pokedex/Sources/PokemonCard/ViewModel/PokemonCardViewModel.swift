//
//  PokemonCardViewModel.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import SwiftUI

class PokemonCardViewModel: PokemonCardViewModelProtocol {
    @Published var pokemonDetails: Pokemon?

    let coordinator: PokemonCardCoordinator
    private let pokemonData: PokemonListResponse.PokemonData
    private let homeViewModel: HomeViewModel?
    private let action: (Pokemon) -> Void

    init(
        coordinator: PokemonCardCoordinator,
        pokemonData: PokemonListResponse.PokemonData,
        homeViewModel: HomeViewModel?,
        action: @escaping (Pokemon) -> Void
    ) {
        self.coordinator = coordinator
        self.pokemonData = pokemonData
        self.homeViewModel = homeViewModel
        self.action = action

        loadPokemonDetails()
    }

    func loadPokemonDetails() {
        Task { @MainActor in
            await homeViewModel?.loadPokemonDetails(for: pokemonData)
            self.pokemonDetails = homeViewModel?.pokemonDetails[pokemonData.name]
        }
    }

    func onTapGesture() {
        guard let pokemonDetails else { return }

        action(pokemonDetails)
    }
}
