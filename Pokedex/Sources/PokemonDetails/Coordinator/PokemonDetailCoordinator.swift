//
//  PokemonDetailCoordinator.swift
//  Pokedex
//
//  Created by Savyo Brenner on 03/10/24.
//

import SwiftUI

class PokemonDetailCoordinator {
    private let pokemon: Pokemon
    private let appCoordinator: AppCoordinator
    private let homeViewModel: (any HomeViewModelProtocol)?

    init(pokemon: Pokemon, appCoordinator: AppCoordinator, homeViewModel: (any HomeViewModelProtocol)?) {
        self.pokemon = pokemon
        self.appCoordinator = appCoordinator
        self.homeViewModel = homeViewModel
    }

    func start() -> AnyView {
        let viewModel = PokemonDetailViewModel(coordinator: self, pokemon: pokemon)
        return AnyView(PokemonDetailView(viewModel: viewModel))
    }

    func popView() {
        appCoordinator.popView()
    }

    func navigateToPokemonType(_ type: String) {
        if let homeViewModel {
            homeViewModel.selectedType = type
        }
        
        popView()
    }
}
