//
//  AppCoordinator.swift
//  Pokedex
//
//  Created by Savyo Brenner on 03/10/24.
//

import SwiftUI

class AppCoordinator: ObservableObject {
    @Published var navigationPath = NavigationPath()

    func start() -> AnyView {
        let splashCoordinator = SplashCoordinator(appCoordinator: self)

        let pathBinding = Binding(
            get: { self.navigationPath },
            set: { self.navigationPath = $0 }
        )

        return AnyView(
            NavigationStack(path: pathBinding) {
                splashCoordinator.start()
                    .navigationDestination(for: AnyViewWrapper.self) { wrapper in
                        wrapper.view
                    }
            }
        )
    }

    func present<Content: View>(_ view: Content) {
        navigationPath.append(AnyViewWrapper(view: view))
    }
}
