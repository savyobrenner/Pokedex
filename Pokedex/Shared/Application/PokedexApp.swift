//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Savyo Brenner on 01/10/24.
//

import SwiftUI

@main
struct PokedexApp: App {
    @StateObject private var appCoordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            appCoordinator.start()
        }
    }
}
