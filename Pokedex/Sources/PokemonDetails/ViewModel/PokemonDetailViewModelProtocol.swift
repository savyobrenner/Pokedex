//
//  PokemonDetailViewModelProtocol.swift
//  Pokedex
//
//  Created by Savyo Brenner on 03/10/24.
//

import SwiftUI

protocol PokemonDetailViewModelProtocol: ObservableObject {
    var pokemon: Pokemon { get }
    var formattedStats: [String] { get }
    var types: [String] { get }
    func onTypeSelected(_ type: String)
}
