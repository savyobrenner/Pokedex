//
//  SplashCoordinator.swift
//  Pokedex
//
//  Created by Savyo Brenner on 01/10/24.
//

class SplashCoordinator: CoordinatorProtocol {
    typealias ContentView = SplashView<SplashViewModel>

    func start() -> SplashView<SplashViewModel> {
        let viewModel = SplashViewModel(coordinator: self)
        return SplashView(viewModel: viewModel)
    }
}
