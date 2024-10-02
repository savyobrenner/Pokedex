//
//  PDImageView.swift
//  Pokedex
//
//  Created by Savyo Brenner on 03/10/24.
//

import SwiftUI

struct PDImageView: View {
    private static let imageCache = NSCache<NSURL, UIImage>()

    let url: URL?
    let placeholderImage: Image
    var contentMode: ContentMode = .fill

    @State private var uiImage: UIImage?
    @State private var isLoading = false

    var body: some View {
        ZStack {
            if let uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                    .clipped()
            } else {
                placeholderImage
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                    .cornerRadius(20)
                    .opacity(0.4)
                    .clipped()
            }

            if isLoading {
                ProgressView()
            }
        }
        .onAppear {
            loadImage()
        }
    }

    private func loadImage() {
        isLoading = true

        guard let url else {
            isLoading = false
            return
        }

        if let cachedImage = PDImageView.imageCache.object(forKey: url as NSURL) {
            self.uiImage = cachedImage
            isLoading = false
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }

            guard let data, let downloadedImage = UIImage(data: data) else {
                return
            }

            PDImageView.imageCache.setObject(downloadedImage, forKey: url as NSURL)

            DispatchQueue.main.async {
                self.uiImage = downloadedImage
            }
        }.resume()
    }
}
