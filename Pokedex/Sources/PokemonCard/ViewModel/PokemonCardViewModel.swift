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
    private let pokemom: Pokemon?
    private let services: HomeServicesProtocol

    init(
        coordinator: PokemonCardCoordinator,
        pokemonData: PokemonListResponse.PokemonData,
        pokemon: Pokemon? = nil,
        services: HomeServicesProtocol = HomeServices()
    ) {
        self.coordinator = coordinator
        self.pokemonData = pokemonData
        self.pokemom = pokemon
        self.services = services
    }
    
    func loadPokemonDetails() {
        Task { @MainActor in
            if let pokemom {
                pokemonDetails = pokemom
                return
            }
            
            do {
                let details = try await services.loadPokemonDetails(from: pokemonData.url)
                self.pokemonDetails = details
            } catch {
                print("Error loading pokemon details (Pokemon Card): \(error)")
            }
        }
    }
}
