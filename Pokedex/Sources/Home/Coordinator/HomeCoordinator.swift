//
//  HomeCoordinator.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

class HomeCoordinator: BaseCoordinator<HomeView<HomeViewModel>> {
    override func start() -> HomeView<HomeViewModel> {
        let viewModel = HomeViewModel(coordinator: self)
        return HomeView(viewModel: viewModel)
    }
}
