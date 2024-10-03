//
//  HomeCoordinator.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import SwiftUI

class HomeCoordinator {
    private var viewModel: HomeViewModel?

    private let appCoordinator: AppCoordinator

    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }

    func start() -> AnyView {
        let services = PokemonServices()
        viewModel = HomeViewModel(coordinator: self, services: services)

        guard let viewModel else { return AnyView(EmptyView()) }

        return AnyView(HomeView(viewModel: viewModel))
    }

    func navigateToDetails(for pokemon: Pokemon) {
        guard let viewModel else { return }
        
        let detailCoordinator = PokemonDetailCoordinator(
            pokemon: pokemon, appCoordinator: appCoordinator, homeViewModel: viewModel
        )

        appCoordinator.present(detailCoordinator.start())
    }
}
