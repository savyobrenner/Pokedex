//
//  SplashViewModelTests.swift
//  PokedexTests
//
//  Created by Savyo Brenner on 04/10/24.
//

import XCTest
@testable import Pokedex

final class SplashViewModelTests: XCTestCase {
    func testSplashAnimation() {
        let coordinator = SplashCoordinator(appCoordinator: AppCoordinator())
        let viewModel = SplashViewModel(coordinator: coordinator)

        XCTAssertEqual(viewModel.ballOffset.width, -300)
        XCTAssertEqual(viewModel.textOpacity, 0.0)

        viewModel.onLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            XCTAssertEqual(viewModel.ballOffset, .zero)
            XCTAssertEqual(viewModel.textOpacity, 1.0)
        }
    }
}
