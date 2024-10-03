//
//  HomeCoordinator.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import SwiftUI

class HomeCoordinator {
    private let appCoordinator: AppCoordinator

    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }

    func start() -> AnyView {
        let services = HomeServices()
        let viewModel = HomeViewModel(coordinator: self, services: services)
        return AnyView(HomeView(viewModel: viewModel))
    }

    func navigateToDetails(for pokemon: Pokemon) {
        let detailCoordinator = PokemonDetailCoordinator(pokemon: pokemon, appCoordinator: appCoordinator)
        appCoordinator.present(detailCoordinator.start())
    }
}
