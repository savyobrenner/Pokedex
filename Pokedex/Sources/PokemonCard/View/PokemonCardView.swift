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
        HStack {
            if let details = viewModel.pokemonDetails {
                VStack(alignment: .leading) {
                    Text("#\(details.id) \(details.name.capitalized)")
                        .font(.headline)
//                    Text("Type: \(details.images.frontalURL.absoluteString ?? "")")
//                        .font(.subheadline)
                }
            }
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.2))
        .cornerRadius(10)
        .padding(.horizontal)
        .onAppear {
            Task {
                await viewModel.loadPokemonDetails()
            }
        }
    }
}
