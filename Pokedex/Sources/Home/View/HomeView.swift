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
                gradient: Gradient(colors: [Color.red, Color.Brand.darkBlue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Pokedex")
                    .font(.brand(.pokemonHollow, size: 36))
                    .foregroundStyle(Color.Brand.white)
                    .padding(.top, 20)
                
                TextField("Search Pokémon by name or ID", text: $viewModel.searchText)
                    .padding()
                    .background(Color.Brand.white.opacity(0.9))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.pokemons, id: \.url) { pokemonData in
                            let coordinator = PokemonCardCoordinator(pokemonData: pokemonData)
                            PokemonCardView(
                                viewModel: PokemonCardViewModel(coordinator: coordinator, pokemonData: pokemonData)
                            )
                            .padding()
                            .shadow(color: Color.Brand.black.opacity(0.2), radius: 10, x: 0, y: 5)
                            .onAppear {
                                if pokemonData == viewModel.pokemons.last {
                                    viewModel.loadMorePokemons()
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.onLoad()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(coordinator: .init(), services: HomeServices()))
}
