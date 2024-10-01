//
//  AppCoordinator.swift
//  Pokedex
//
//  Created by Savyo Brenner on 01/10/24.
//

import SwiftUI

class AppCoordinator: ObservableObject {
    @Published var navigationPath = NavigationPath()

    func startSplash() {
        navigationPath.append(SplashCoordinator())
    }

    func navigateToHome() {
        
    }
}
