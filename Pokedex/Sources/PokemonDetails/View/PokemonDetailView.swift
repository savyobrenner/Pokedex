//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Savyo Brenner on 03/10/24.
//

import SwiftUI

struct PokemonDetailView<ViewModel: PokemonDetailViewModelProtocol>: View {
    @ObservedObject
    var viewModel: ViewModel

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.red, Color.Brand.darkBlue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(spacing: 20) {
                    VStack(spacing: 10) {
                        Text(viewModel.pokemon.name.capitalized)
                            .font(.brand(.bold, size: 24))
                            .foregroundStyle(Color.Brand.white)
                            .shadow(radius: 3)

                        Text("#\(viewModel.pokemon.id)")
                            .font(.brand(.bold, size: 24))
                            .foregroundStyle(Color.Brand.white)
                    }

                    if let images = viewModel.pokemon.images {
                        let nonEmptyImages = [
                            images.frontDefault,
                            images.backDefault,
                            images.frontShiny,
                            images.backShiny,
                            images.frontFemale,
                            images.backFemale,
                            images.frontShinyFemale,
                            images.backShinyFemale
                        ].compactMap { $0 }

                        if !nonEmptyImages.isEmpty {
                            PDImageCarouselView(images: nonEmptyImages)
                                .padding(.vertical)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(radius: 10)
                                .padding(.horizontal)
                        }
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Types")
                                .font(.brand(.bold, size: 20))
                                .foregroundStyle(Color.Brand.white)

                            Spacer()
                        }

                            HStack {
                                ForEach(viewModel.types, id: \.self) { type in
                                    Button {
                                        viewModel.onTypeSelected(type)
                                    } label: {
                                        Text(type.capitalized)
                                            .font(.brand(.bold, size: 14))
                                            .padding(10)
                                            .background(randomTypeColor())
                                            .foregroundStyle(Color.Brand.white)
                                            .cornerRadius(8)
                                            .shadow(radius: 3)
                                    }
                                }
                            }
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Stats")
                            .font(.brand(.bold, size: 20))
                            .foregroundStyle(Color.Brand.white)
                            .padding(.bottom, 5)

                        VStack(spacing: 10) {
                            ForEach(viewModel.formattedStats, id: \.self) { stat in
                                HStack {
                                    Text(stat)
                                        .font(.brand(.regular, size: 14))
                                        .foregroundStyle(Color.Brand.white)
                                        .padding(10)

                                    Spacer()
                                }
                                .background(Color.Brand.white.opacity(0.1))
                                .cornerRadius(12)
                                .shadow(radius: 3)
                            }
                        }
                    }

                    Spacer()
                }
                .padding()
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }

    private func randomTypeColor() -> Color {
        Color(
            red: Double.random(in: 0.5...1),
            green: Double.random(in: 0.5...1),
            blue: Double.random(in: 0.5...1)
        )
    }
}
