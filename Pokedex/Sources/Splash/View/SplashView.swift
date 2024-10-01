//
//  SplashView.swift
//  Pokedex
//
//  Created by Savyo Brenner on 01/10/24.
//

import SwiftUI

struct SplashView<ViewModel: SplashViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        ZStack {
            Color.Brand.black
                .ignoresSafeArea()

            VStack {
                Image(.pokeballIcon)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .offset(viewModel.ballOffset)

                Text("Pokedex")
                    .font(.brand(.pokemonHollow, size: 50))
                    .foregroundStyle(Color.Brand.white)
                    .opacity(viewModel.textOpacity)
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

#Preview {
    SplashView(viewModel: SplashViewModel(coordinator: .init()))
}
