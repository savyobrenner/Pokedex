//
//  PokemonCardView.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import SwiftUI

struct PokemonCardView<ViewModel: PokemonCardViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.6)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .shadow(color: Color.purple.opacity(0.4), radius: 10, x: 0, y: 10)

            HStack {
                if let details = viewModel.pokemonDetails {
                    PDImageView(
                        url: details.images?.frontDefault,
                        placeholderImage: .init(.pokedexImagePlaceholder)
                    )
                    .frame(width: 80, height: 80)
                    .padding()

                    VStack(alignment: .leading, spacing: 8) {
                        Text("#\(details.id) \(details.name.capitalized)")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        // Adicionando um exemplo de tipo do Pokémon com chips futuristas
//                        HStack {
//                            ForEach(details.types, id: \.type.name) { type in
//                                Text(type.type.name.capitalized)
//                                    .font(.caption)
//                                    .padding(8)
//                                    .background(Color.white.opacity(0.2))
//                                    .clipShape(Capsule())
//                                    .foregroundColor(.white)
//                            }
//                        }
                    }
                    Spacer()
                }
            }
            .padding()
        }
        .frame(height: 150)
        .padding(.horizontal)
        .onAppear {
            Task {
                await viewModel.loadPokemonDetails()
            }
        }
    }
}
