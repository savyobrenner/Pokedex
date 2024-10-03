//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Savyo Brenner on 03/10/24.
//

import SwiftUI

struct PokemonDetailView<ViewModel: PokemonDetailViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(viewModel.pokemon.name.capitalized)
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("#\(viewModel.pokemon.id)")
                .font(.title3)
                .foregroundColor(.gray)

            HStack(spacing: 20) {
                if let frontDefaultURL = viewModel.pokemon.images?.frontDefault {
                    PDImageView(url: frontDefaultURL, placeholderImage: .init(.pokedexImagePlaceholder))
                        .frame(width: 100, height: 100)
                }

                if let frontShinyURL = viewModel.pokemon.images?.frontShiny {
                    PDImageView(url: frontShinyURL, placeholderImage: .init(.pokedexImagePlaceholder))
                        .frame(width: 100, height: 100)
                }
            }

            VStack(alignment: .leading) {
                Text("Types")
                    .font(.headline)

                HStack {
                    ForEach(viewModel.types, id: \.self) { type in
                        Button(action: {
                            viewModel.onTypeSelected(type)
                        }) {
                            Text(type.capitalized)
                                .padding(10)
                                .background(typeColor(type))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                }
            }

            VStack(alignment: .leading) {
                Text("Stats")
                    .font(.headline)

                ForEach(viewModel.formattedStats, id: \.self) { stat in
                    Text(stat)
                        .font(.body)
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Pokemon Details")
    }

    private func typeColor(_ type: String) -> Color {
        // Retorna uma cor com base no tipo de Pokémon
        switch type.lowercased() {
        case "fire": return .red
        case "water": return .blue
        case "grass": return .green
        case "electric": return .yellow
        case "psychic": return .purple
        case "rock": return .brown
        case "ground": return .orange
        // Adicione outras cores para tipos diferentes aqui
        default: return .gray
        }
    }
}
