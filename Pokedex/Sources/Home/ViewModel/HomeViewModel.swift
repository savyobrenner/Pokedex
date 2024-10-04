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

    @Published
    var showingAlert = false

    @Published
    var alertMessage = ""

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
                showAlert(with: "Failed to load Pokémon. Please try again later.")
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
                nextURL = response.next
                pokemons.append(contentsOf: response.results)
                allPokemons.append(contentsOf: response.results)
            } catch {
                showAlert(with: "Failed to load more Pokémon. Please try again later.")
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
                    pokemons = [PokemonListResponse.PokemonData(name: pokemon.name, url: searchURL)]
                    pokemonDetails[pokemon.name] = pokemon
                } catch {
                    // This is intentional, we have a treatment to check if the 'pokemons' object is nil
                    debugPrint("Error searching pokemons: \(error)")
                }
            } else {
                let filteredPokemons = allPokemons.filter { pokemon in
                    pokemon.name == lowercasedQuery
                }

                if filteredPokemons.isEmpty {
                    do {
                        let pokemon = try await services.searchPokemon(nameOrId: lowercasedQuery)
                        pokemons = [PokemonListResponse.PokemonData(name: pokemon.name, url: searchURL)]
                        pokemonDetails[pokemon.name] = pokemon
                    } catch {
                        // This is intentional, we have a treatment to check if the 'pokemons' object is nil
                        debugPrint("Error searching pokemons: \(error)")
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
                showAlert(with: "Failed to load Pokémon types. Please try again later.")
            }
        }
    }

    func searchPokemonByType(_ type: String) async {
        Task { @MainActor in
            isLoading = true
            isSearching = true
            pokemons = []

            defer {
                isLoading = false
            }

            do {
                let pokemonsOfType = try await services.loadPokemonsByType(type)
                pokemons = pokemonsOfType
            } catch {
                // This is intentional, we have a treatment to check if the 'pokemons' object is nil
                debugPrint("Error searching pokemons: \(error)")
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
            try? await Task.sleep(nanoseconds: 900_000_000)

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

    private func showAlert(with message: String) {
        alertMessage = message
        showingAlert = true
    }
}
