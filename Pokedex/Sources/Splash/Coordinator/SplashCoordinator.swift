//
//  SplashCoordinator.swift
//  Pokedex
//
//  Created by Savyo Brenner on 01/10/24.
//

import SwiftUI

class SplashCoordinator: ObservableObject {
    private let appCoordinator: AppCoordinator

    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }

    func start() -> AnyView {
        let viewModel = SplashViewModel(coordinator: self)
        return AnyView(SplashView(viewModel: viewModel))
    }

    func finishSplash() {
        let homeCoordinator = HomeCoordinator(appCoordinator: appCoordinator)
        appCoordinator.present(homeCoordinator.start())
    }
}
