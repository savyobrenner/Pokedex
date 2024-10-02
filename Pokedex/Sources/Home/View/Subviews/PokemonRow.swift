//
//  PokemonRow.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import SwiftUI

struct PokemonRow: View {
    let pokemonData: PokemonListResponse.PokemonData
    let pokemonDetails: Pokemon?

    var body: some View {
        HStack {
            if let details = pokemonDetails {
                VStack(alignment: .leading) {
                    Text("#\(details.id) \(details.name.capitalized)")
                        .font(.headline)
//                    Text("Type: \(details.types.map { $0.type.name }.joined(separator: ", "))")
//                        .font(.subheadline)
                }
            } else {
                Text(pokemonData.name.capitalized)
                    .font(.headline)
            }
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.2))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}
