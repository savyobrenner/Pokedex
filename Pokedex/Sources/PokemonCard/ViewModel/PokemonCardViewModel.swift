//
//  PokemonCardViewModel.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import SwiftUI

class PokemonCardViewModel: PokemonCardViewModelProtocol {
    @Published var pokemonDetails: Pokemon?
    @Published var isLoading = false

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
        guard pokemonDetails == nil else { return }

        if let cachedDetails = homeViewModel?.pokemonDetails[pokemonData.name] {
            self.pokemonDetails = cachedDetails
            return
        }

        Task { @MainActor in
            await homeViewModel?.loadPokemonDetails(for: pokemonData)
            pokemonDetails = homeViewModel?.pokemonDetails[pokemonData.name]
        }
    }

    func onTapGesture() {
        guard let pokemonDetails else { return }

        action(pokemonDetails)
    }
}
