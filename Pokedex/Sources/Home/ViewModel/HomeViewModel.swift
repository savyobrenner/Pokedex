//
//  HomeViewModel.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import SwiftUI

class HomeViewModel: HomeViewModelProtocol {
    @Published var pokemons: [Pokemon] = []
    @Published var searchText: String = "" {
        didSet {
            handleSearchTextChange()
        }
    }

    private let coordinator: HomeCoordinator
    private let services: HomeServicesProtocol
    private var nextURL: URL? = nil
    private var isLoading = false
    private var loadedURLs: Set<URL> = []

    init(coordinator: HomeCoordinator, services: HomeServicesProtocol = HomeServices()) {
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
                self.loadPokemonDetails(for: response.results)
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
                self.loadPokemonDetails(for: response.results)
            }
        } catch {
            print("Error loading more pokemons: \(error)")
        }
    }

    private func loadPokemonDetails(for pokemonDataList: [PokemonListResponse.PokemonData]) {
        for pokemonData in pokemonDataList {
            guard !loadedURLs.contains(pokemonData.url) else { continue }
            loadedURLs.insert(pokemonData.url)

            Task {
                do {
                    let pokemon = try await services.loadPokemonDetails(from: pokemonData.url)
                    DispatchQueue.main.async {
                        self.pokemons.append(pokemon)
                    }
                } catch {
                    print("Error loading pokemon details: \(error)")
                }
            }
        }
    }

    func searchPokemon(by nameOrId: String) async {
        do {
            let pokemon = try await services.searchPokemon(nameOrId: nameOrId)
            DispatchQueue.main.async {
                self.pokemons = [pokemon]
            }
        } catch {
            print("Error searching pokemon: \(error)")
        }
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
        Task {
            await loadInitialPokemons()
        }
    }
}
