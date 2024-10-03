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
    var isSearching = false

    private var nextURL: URL?
    private var isLoading = false
    private var loadedURLs: Set<URL> = []
    private var allPokemons: [PokemonListResponse.PokemonData] = []

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

    func loadMorePokemons() {
        guard !isLoading, let url = nextURL else { return }

        isLoading = true

        Task {
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

    func loadPokemonDetails(for url: URL) async {
        guard !loadedURLs.contains(url) else { return }

        loadedURLs.insert(url)

        Task { @MainActor in
            do {
                let pokemon = try await services.loadPokemonDetails(from: url)

                self.pokemonDetails[pokemon.name] = pokemon

            } catch {
                // TODO: - Implement error handling
                print("Error loading pokemon details: \(error)")
            }
        }
    }

    func searchPokemon(by nameOrId: String) async {
        let lowercasedQuery = nameOrId.lowercased()


        guard let searchURL = URL(
            string: AppConstants.searchByNameOrIdURL.replacingOccurrences(of: "%@", with: lowercasedQuery)
        ) else {
            return
        }

        Task { @MainActor in
            isSearching = true
            self.pokemons = []

            defer {
                isSearching = false
            }

            // If it's an ID we make the request directly
            if let pokemonId = Int(lowercasedQuery) {
                do {
                    let pokemon = try await services.searchPokemon(nameOrId: String(pokemonId))

                    self.pokemons = [PokemonListResponse.PokemonData(name: pokemon.name, url: searchURL)]

                    self.pokemonDetails[pokemon.name] = pokemon
                } catch {
                    // TODO: - Implement error handling
                    print("Error loading pokemon details: \(error)")
                }
            } else {
                let filteredPokemons = allPokemons.filter { pokemon in
                    pokemon.name.lowercased().contains(lowercasedQuery)
                }

                if filteredPokemons.isEmpty {
                    do {
                        let pokemon = try await services.searchPokemon(nameOrId: lowercasedQuery)

                        self.pokemons = [PokemonListResponse.PokemonData(name: pokemon.name, url: searchURL)]
                        self.pokemonDetails[pokemon.name] = pokemon
                    } catch {
                        // TODO: - Implement error handling
                        print("Error loading pokemon details: \(error)")
                    }
                } else {
                    self.pokemons = filteredPokemons
                }
            }
        }
    }

    private func handleSearchTextChange() {
        guard !searchText.isEmpty else { return }

        Task {
            try? await Task.sleep(nanoseconds: 100000000)

            if searchText.isEmpty {
                resetFilter()
            } else {
                await searchPokemon(by: searchText)
            }
        }
    }

    private func resetFilter() {
        DispatchQueue.main.async {
            self.pokemons = self.allPokemons
        }
    }
}
