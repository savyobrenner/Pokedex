//
//  HomeViewModel.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import SwiftUI

class HomeViewModel: HomeViewModelProtocol {
    @Published
    var isLoading = false

    @Published
    var isSearching = false

    @Published
    var pokemons: [PokemonListResponse.PokemonData] = []

    @Published
    var pokemonDetails: [String: Pokemon] = [:]

    @Published
    var searchText = "" {
        didSet {
            handleSearchTextChange()
        }
    }

    @Published
    var selectedType = "" {
        didSet {
            handleTypeSelectionChange()
        }
    }

    @Published
    var availableTypes: [String] = []

    private var nextURL: URL?
    private var loadedURLs: Set<URL> = []
    private var allPokemons: [PokemonListResponse.PokemonData] = []

    private var searchTask: Task<Void, Never>?

    let coordinator: HomeCoordinator
    private let services: PokemonServicesProtocol

    init(coordinator: HomeCoordinator, services: PokemonServicesProtocol) {
        self.coordinator = coordinator
        self.services = services
    }

    func onLoad() {
        Task {
            await loadPokemonTypes()
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

            if !selectedType.isEmpty {
                selectedType = ""
            }

            guard let searchURL = URL(
                string: AppConstants.searchByNameOrIdURL.replacingOccurrences(of: "%@", with: lowercasedQuery)
            ) else {
                return
            }

            isLoading = true
            isSearching = true
            pokemons = []

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

    func loadPokemonTypes() async {
        Task { @MainActor in
            do {
                let response = try await services.loadTypes()
                availableTypes = response.results.map { $0.name }
            } catch {
                print("Error loading Pokémon types: \(error)")
            }
        }
    }

    func searchPokemonByType(_ type: String) async {
        Task { @MainActor in
            isLoading = true
            isSearching = true
            self.pokemons = []

            defer {
                isLoading = false
            }

            do {
                let pokemonsOfType = try await services.loadPokemonsByType(type)
                self.pokemons = pokemonsOfType
            } catch {
                print("Error loading pokemons by type: \(error)")
            }
        }
    }

    func navigateToDetails(for pokemon: Pokemon) {
        coordinator.navigateToDetails(for: pokemon)
    }

    private func handleTypeSelectionChange() {
        if !selectedType.isEmpty {
            searchText = ""
        }

        guard !selectedType.isEmpty else {
            resetFilter()
            return
        }

        Task { @MainActor in
            await searchPokemonByType(selectedType)
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
