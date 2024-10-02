//
//  HomeViewModel.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import SwiftUI

class HomeViewModel: HomeViewModelProtocol {
    @Published var pokemons: [PokemonListResponse.PokemonData] = [] // Armazena dados básicos de Pokémon
    @Published var pokemonDetails: [String: Pokemon] = [:] // Armazena os detalhes dos Pokémon por nome/URL
    @Published var searchText: String = "" {
        didSet {
            handleSearchTextChange()
        }
    }

    let coordinator: HomeCoordinator
    private let services: HomeServicesProtocol
    private var nextURL: URL? = nil
    private var isLoading = false
    private var loadedURLs: Set<URL> = []

    init(coordinator: HomeCoordinator, services: HomeServicesProtocol) {
        self.coordinator = coordinator
        self.services = services
    }

    func onLoad() {
        Task {
            await loadInitialPokemons()
        }
    }

    private func loadInitialPokemons() async {
        guard !isLoading else { return }

        isLoading = true
        defer { isLoading = false }

        do {
            let response = try await services.loadPokemons(limit: 20, offset: 0)
            DispatchQueue.main.async {
                self.nextURL = response.next
                self.pokemons.append(contentsOf: response.results)
            }
        } catch {
            print("Error loading initial pokemons: \(error)")
        }
    }

    func loadMorePokemons() async {
        guard !isLoading, let url = nextURL else { return }
        isLoading = true
        defer { isLoading = false }

        do {
            let response = try await services.loadPokemons(from: url)
            DispatchQueue.main.async {
                self.nextURL = response.next
                self.pokemons.append(contentsOf: response.results)
            }
        } catch {
            print("Error loading more pokemons: \(error)")
        }
    }

    func loadPokemonDetails(for url: URL) async {
        guard !loadedURLs.contains(url) else { return }
        loadedURLs.insert(url)

        do {
            let pokemon = try await services.loadPokemonDetails(from: url)
            DispatchQueue.main.async {
                self.pokemonDetails[pokemon.name] = pokemon
            }
        } catch {
            print("Error loading pokemon details: \(error)")
        }
    }

    func searchPokemon(by nameOrId: String) async {
//        do {
//            let pokemon = try await services.searchPokemon(nameOrId: nameOrId)
//            DispatchQueue.main.async {
//                self.pokemons = [PokemonListResponse.PokemonData(name: pokemon.name, url: pokemon.url)]
//                self.pokemonDetails[pokemon.name] = pokemon
//            }
//        } catch {
//            print("Error searching pokemon: \(error)")
//        }
    }

    private func handleSearchTextChange() {
        Task {
            // Delay para simular debounce
            try? await Task.sleep(nanoseconds: 500_000_000)
            if searchText.isEmpty {
                resetPokemons()
            } else {
                await searchPokemon(by: searchText)
            }
        }
    }

    private func resetPokemons() {
        nextURL = nil
        pokemons.removeAll()
        loadedURLs.removeAll()
        pokemonDetails.removeAll()
        Task {
            await loadInitialPokemons()
        }
    }
}
