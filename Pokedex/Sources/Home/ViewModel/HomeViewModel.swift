//
//  HomeViewModel.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import SwiftUI

class HomeViewModel: HomeViewModelProtocol {
    @Published
    var pokemons: [PokemonListResponse.PokemonData] = []

    @Published
    var pokemonDetails: [String: Pokemon] = [:]

    @Published
    var searchText: String = "" {
        didSet {
            handleSearchTextChange()
        }
    }

    @Published
    var isLoading = false

    @Published
    var isSearching = false

    private var nextURL: URL?
    private var loadedURLs: Set<URL> = []
    private var allPokemons: [PokemonListResponse.PokemonData] = []

    private var searchTask: Task<Void, Never>?

    let coordinator: HomeCoordinator
    private let services: HomeServicesProtocol

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
        Task { @MainActor in
            isLoading = true
            defer { isLoading = false }

            do {
                let response = try await services.loadPokemons(limit: 20, offset: 0)

                DispatchQueue.main.async { [weak self] in
                    self?.nextURL = response.next
                    self?.pokemons.append(contentsOf: response.results)
                    self?.allPokemons.append(contentsOf: response.results)
                }
            } catch {
                // TODO: - Implement error handling
                print("Error loading initial pokemons: \(error)")
            }
        }
    }

    func loadMorePokemons() {
        guard !isLoading, let url = nextURL else { return }

        isLoading = true

        Task { @MainActor in
            defer { isLoading = false }

            do {
                let response = try await services.loadPokemons(from: url)

                DispatchQueue.main.async { [weak self] in
                    self?.nextURL = response.next
                    self?.pokemons.append(contentsOf: response.results)
                    self?.allPokemons.append(contentsOf: response.results)
                }
            } catch {
                // TODO: - Implement error handling
                print("Error loading more pokemons: \(error)")
            }
        }
    }

    func searchPokemon(by nameOrId: String) async {
        let lowercasedQuery = nameOrId.lowercased()

        Task { @MainActor in

            searchTask?.cancel()

            guard let searchURL = URL(
                string: AppConstants.searchByNameOrIdURL.replacingOccurrences(of: "%@", with: lowercasedQuery)
            ) else {
                return
            }
            
            isLoading = true
            isSearching = true
            self.pokemons = []

            defer {
                isLoading = false
            }

            // If it's an ID we make the request directly
            if let pokemonId = Int(lowercasedQuery) {
                do {
                    let pokemon = try await services.searchPokemon(nameOrId: String(pokemonId))
                    self.pokemons = [PokemonListResponse.PokemonData(name: pokemon.name, url: searchURL)]
                    self.pokemonDetails[pokemon.name] = pokemon
                } catch {
                    print("Error loading pokemon details: \(error)")
                }
            } else {
                let filteredPokemons = allPokemons.filter { pokemon in
                    pokemon.name == lowercasedQuery
                }

                if filteredPokemons.isEmpty {
                    do {
                        let pokemon = try await services.searchPokemon(nameOrId: lowercasedQuery)
                        self.pokemons = [PokemonListResponse.PokemonData(name: pokemon.name, url: searchURL)]
                        self.pokemonDetails[pokemon.name] = pokemon
                    } catch {
                        print("Error loading pokemon details: \(error)")
                    }
                } else {
                    self.pokemons = filteredPokemons
                }
            }
        }
    }

    private func handleSearchTextChange() {
        searchTask?.cancel()

        guard !searchText.isEmpty else {
            resetFilter()
            return
        }

        searchTask = Task { [weak self] in
            try? await Task.sleep(nanoseconds: 100_000_000)

            guard let self, !Task.isCancelled else { return }
            await self.searchPokemon(by: self.searchText)
        }
    }

    private func resetFilter() {
        DispatchQueue.main.async {
            self.pokemons = self.allPokemons
            self.isSearching = false
        }
    }
}
