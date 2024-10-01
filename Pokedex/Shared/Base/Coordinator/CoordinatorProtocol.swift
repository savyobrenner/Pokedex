//
//  CoordinatorProtocol.swift
//  Pokedex
//
//  Created by Savyo Brenner on 01/10/24.
//

import SwiftUI

protocol CoordinatorProtocol: Hashable {
    associatedtype ContentView: View
    func start() -> ContentView
}

extension CoordinatorProtocol {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs === rhs
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
