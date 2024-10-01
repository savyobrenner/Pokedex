//
//  AnyViewWrapper.swift
//  Pokedex
//
//  Created by Savyo Brenner on 01/10/24.
//

import SwiftUI

struct AnyViewWrapper: Hashable {
    let id = UUID()
    let view: AnyView

    init<Content: View>(view: Content) {
        self.view = AnyView(view)
    }

    static func == (lhs: AnyViewWrapper, rhs: AnyViewWrapper) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
