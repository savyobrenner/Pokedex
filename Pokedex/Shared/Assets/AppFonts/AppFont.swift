//
//  AppFont.swift
//  Pokedex
//
//  Created by Savyo Brenner on 01/10/24.
//

import SwiftUI

extension Font {
    static func brand(_ name: BrandFontName = .regular, size: CGFloat = 16, relativeTo: TextStyle = .body) -> Font {
        .custom(name.rawValue, size: size, relativeTo: relativeTo)
    }
}
