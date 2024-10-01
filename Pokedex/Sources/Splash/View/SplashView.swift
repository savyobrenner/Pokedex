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
            Color.red
                .ignoresSafeArea()
        }
    }
}

#Preview {
    SplashView(viewModel: SplashViewModel(coordinator: .init()))
}
