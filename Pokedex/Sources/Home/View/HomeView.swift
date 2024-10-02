//
//  HomeView.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import SwiftUI

struct HomeView<ViewModel: HomeViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.red, Color.Brand.black]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)

            VStack {
                Text("Pokedex")
                    .font(.brand(.pokemonHollow, size: 50))
                    .foregroundStyle(Color.Brand.secondary)

                // Search Bar
                TextField("Search Pokémon by name or ID", text: $viewModel.searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                // Pokémon List
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.pokemons) { pokemon in
                            PokemonRow(pokemon: pokemon)
                                .onAppear {
                                    // Carrega mais Pokémon se estiver próximo do final da lista
                                    if pokemon == viewModel.pokemons.last {
                                        Task {
                                            await viewModel.loadMorePokemons()
                                        }
                                    }
                                }
                        }
                    }
                }

                Spacer()
            }
            .padding()
        }
        .onAppear {
            viewModel.onLoad() // Chama onLoad para carregar os Pokémon iniciais
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(coordinator: .init()))
}
