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

                    Text("#\(details.id) \(details.name.capitalized)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                } else {
                    HStack {
                        Image(.pokedexImagePlaceholder)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(20)
                            .opacity(0.4)
                            .clipped()

                        Text("Loading...")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
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

#Preview {
    // MARK: - The force unwrap is only "acceptable" here because it's for preview purposes and does not interfere with the running app
    let pokemonData = PokemonListResponse.PokemonData(
        name: "nScren",
        url: .init(string: "https://pokeapi.co/api/v2/ability/65/")!
    )

    return PokemonCardCoordinator(pokemonData: pokemonData).start()
}
