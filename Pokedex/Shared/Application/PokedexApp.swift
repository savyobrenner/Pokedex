//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Savyo Brenner on 01/10/24.
//

import SwiftUI

@main
struct PokedexApp: App {
    @StateObject private var splashCoordinator = SplashCoordinator()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $splashCoordinator.navigationPath) {
                splashCoordinator.start()
                    .navigationDestination(for: AnyViewWrapper.self) { wrapper in
                        wrapper.view
                    }
            }
        }
    }
}
