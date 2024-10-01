//
//  SplashCoordinator.swift
//  Pokedex
//
//  Created by Savyo Brenner on 01/10/24.
//

class SplashCoordinator: BaseCoordinator<SplashView<SplashViewModel>> {
    override func start() -> SplashView<SplashViewModel> {
        let viewModel = SplashViewModel(coordinator: self)
        return SplashView(viewModel: viewModel)
    }

    enum Navigation {
        case home
    }

    func navigate(to navigation: Navigation) {
        switch navigation {
        case .home:
            let homeCoordinator = HomeCoordinator()
            present(homeCoordinator.start())
        }
    }
}
