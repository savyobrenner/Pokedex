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
                    gradient: Gradient(colors: [Color.Brand.blue, Color.Brand.navyBlue]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .shadow(color: Color.Brand.black.opacity(0.3), radius: 10, x: 0, y: 5)

            HStack {
                if let details = viewModel.pokemonDetails {
                    PDImageView(
                        url: details.images?.frontDefault,
                        placeholderImage: .init(.pokedexImagePlaceholder)
                    )
                    .frame(width: 80, height: 80)
                    .padding()
                    .background {
                        Circle()
                            .foregroundStyle(Color.Brand.white.opacity(0.3))
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("#\(details.id) \(details.name.capitalized)")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .padding(.leading)

                    Spacer()
                } else {
                    HStack {
                        Image(.pokedexImagePlaceholder)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                            .opacity(0.4)
                            .clipped()
                            .frame(width: 80, height: 80)

                        Text("Loading...")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }

                    Spacer()
                }
            }
            .padding()
        }
        .frame(height: 120)
        .onAppear {
            viewModel.loadPokemonDetails()
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
