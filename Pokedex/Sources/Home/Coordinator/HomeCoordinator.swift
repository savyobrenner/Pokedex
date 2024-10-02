//
//  HomeCoordinator.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

class HomeCoordinator: BaseCoordinator<HomeView<HomeViewModel>> {
    override func start() -> HomeView<HomeViewModel> {
        let services = HomeServices()
        let viewModel = HomeViewModel(coordinator: self, services: services)
        return HomeView(viewModel: viewModel)
    }
}
