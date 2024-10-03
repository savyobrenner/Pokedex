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
                PDImageView(url: url, placeholderImage: .init(.pokedexImagePlaceholder), contentMode: .fit)
                    .shadow(radius: 5)
            }
            .padding(.vertical, 16)
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(height: 160)
    }
}
