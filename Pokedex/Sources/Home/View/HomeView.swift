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

                PDTextField(text: $viewModel.searchText, placeholder: "Search Pokémon by name or ID")
                    .padding()
                    .background(Color.Brand.white.opacity(0.9))
                    .frame(height: 50)
                    .cornerRadius(10)
                    .padding(.horizontal)

                ScrollViewReader { scrollProxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            Button {
                                viewModel.selectedType = ""
                            } label: {
                                Text("All Types")
                                    .font(.brand(.bold, size: 16))
                                    .padding()
                                    .background(viewModel.selectedType.isEmpty ? Color.Brand.blue : Color.Brand.white)
                                    .foregroundColor(viewModel.selectedType.isEmpty ? Color.Brand.white : Color.Brand.black)
                                    .cornerRadius(10)
                                    .id("allTypes")
                            }

                            ForEach(viewModel.availableTypes, id: \.self) { type in
                                Button(action: {
                                    viewModel.selectedType = type
                                }) {
                                    Text(type.capitalized)
                                        .font(.brand(.bold, size: 16))
                                        .padding()
                                        .background(
                                            viewModel.selectedType == type
                                            ? Color.Brand.blue
                                            : Color.Brand.white
                                        )
                                        .foregroundColor(
                                            viewModel.selectedType == type
                                            ? Color.Brand.white
                                            : Color.Brand.black
                                        )
                                        .cornerRadius(10)
                                }
                                .id(type)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .onChange(of: viewModel.selectedType) { selectedType in
                        if selectedType.isEmpty {
                            scrollProxy.scrollTo("allTypes", anchor: .center)
                        } else {
                            scrollProxy.scrollTo(selectedType, anchor: .center)
                        }
                    }
                }

                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                        .foregroundStyle(Color.Brand.white)
                } else if viewModel.pokemons.isEmpty && viewModel.isSearching {
                    Text("No Pokémon found, please try another search.")
                        .font(.brand(.black, size: 20))
                        .foregroundStyle(Color.Brand.white)
                        .multilineTextAlignment(.center)
                        .padding(.top, 50)
                }
                
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.pokemons, id: \.url) { pokemonData in
                            let coordinator = PokemonCardCoordinator(
                                pokemonData: pokemonData, pokemon: viewModel.pokemonDetails[pokemonData.name]
                            ) { pokemon in
                                viewModel.navigateToDetails(for: pokemon)
                            }
                            
                            coordinator.start()
                                .padding()
                                .shadow(color: Color.Brand.black.opacity(0.2), radius: 10, x: 0, y: 5)
                                .onAppear {
                                    if pokemonData == viewModel.pokemons.last,
                                       !viewModel.isSearching,
                                       !viewModel.isLoading {
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
        .alert(isPresented: $viewModel.showingAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(coordinator: .init(appCoordinator: .init()), services: PokemonServices()))
}
