//
//  Color+Extensions.swift
//  Pokedex
//
//  Created by Savyo Brenner on 03/10/24.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hexInt = Int(hex, radix: 16) ?? 0
        self.init(
            red: Double((hexInt >> 16) & 0xFF) / 255.0,
            green: Double((hexInt >> 8) & 0xFF) / 255.0,
            blue: Double(hexInt & 0xFF) / 255.0
        )
    }
}
