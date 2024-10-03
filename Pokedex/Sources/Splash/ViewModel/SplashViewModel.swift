//
//  SplashViewModel.swift
//  Pokedex
//
//  Created by Savyo Brenner on 01/10/24.
//

import SwiftUI

class SplashViewModel: SplashViewModelProtocol {
    @Published var ballOffset: CGSize = CGSize(width: -300, height: 0)
    @Published var textOpacity: Double = 0.0

    let coordinator: SplashCoordinator

    init(coordinator: SplashCoordinator) {
        self.coordinator = coordinator
    }

    func onLoad() {
        DispatchQueue.main.async { [weak self] in
            self?.animateBallEntry()
            self?.animateTextAppearance()
        }
    }

    private func animateBallEntry() {
        withAnimation(.interpolatingSpring(stiffness: 100, damping: 10)) {
            ballOffset = .zero
        }
    }

    private func animateTextAppearance() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            withAnimation(.easeIn(duration: 1.0)) {
                self?.textOpacity = 1.0
            }

            // Navigate to home after animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                self?.navigateToHome()
            }
        }
    }

    private func navigateToHome() {
        coordinator.finishSplash()
    }
}
