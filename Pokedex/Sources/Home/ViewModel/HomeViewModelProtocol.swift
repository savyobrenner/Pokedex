//
//  HomeViewModelProtocol.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import SwiftUI

protocol HomeViewModelProtocol: ObservableObject {
    var pokemons: [Pokemon] { get }
    var searchText: String { get set }
    func onLoad()
    func loadMorePokemons() async
    func searchPokemon(by nameOrId: String) async
}
