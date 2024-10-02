//
//  PokemonRow.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import SwiftUI


struct PokemonRow: View {
    let pokemon: Pokemon

    var body: some View {
        HStack {
            Text("#\(pokemon.id) \(pokemon.name.capitalized)")
                .font(.headline)
            
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.2))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}
