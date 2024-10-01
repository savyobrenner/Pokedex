//
//  BaseCoordinator.swift
//  Pokedex
//
//  Created by Savyo Brenner on 01/10/24.
//

import SwiftUI

class BaseCoordinator<Content: View>: ObservableObject, CoordinatorProtocol, Hashable {
    typealias ContentView = Content

    @Published var navigationPath = NavigationPath()

    func start() -> Content {
        fatalError("Subclasses need to implement `start()`.")
    }

    func present<PresentedView: View>(_ view: PresentedView) {
        navigationPath.append(AnyViewWrapper(view: view))
    }

    func pop() {
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
    }

    static func == (lhs: BaseCoordinator, rhs: BaseCoordinator) -> Bool {
        return lhs === rhs
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
