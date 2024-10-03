//
//  PDImageCarouselView.swift
//  Pokedex
//
//  Created by Savyo Brenner on 04/10/24.
//

import SwiftUI

struct PDImageCarouselView: View {
    let images: [URL]

    var body: some View {
        TabView {
            ForEach(images, id: \.self) { url in
                PDImageView(url: url, placeholderImage: .init(.pokedexImagePlaceholder))
                    .frame(height: 100) // Tamanho menor para as imagens
                    .padding(10)
                    .background(Color.white.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 5)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(height: 150)
    }
}
