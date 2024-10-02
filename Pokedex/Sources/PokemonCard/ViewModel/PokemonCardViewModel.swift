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
    private let services: HomeServicesProtocol

    init(coordinator: PokemonCardCoordinator, pokemonData: PokemonListResponse.PokemonData, services: HomeServicesProtocol = HomeServices()) {
        self.coordinator = coordinator
        self.pokemonData = pokemonData
        self.services = services
    }

    func loadPokemonDetails() async {
        do {
            let details = try await services.loadPokemonDetails(from: pokemonData.url)
            DispatchQueue.main.async {
                self.pokemonDetails = details
            }
        } catch {
            print("Error loading pokemon details (Pokemon Card): \(error)")
        }
    }
}
