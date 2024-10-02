//
//  PDImageDownloader.swift
//  Pokedex
//
//  Created by Savyo Brenner on 03/10/24.
//

import SwiftUI

struct PDImageDownloader: View {
    private static let imageCache = NSCache<NSURL, UIImage>()
    
    let url: URL
    let placeholderImage: Image
    
    @State
    private var uiImage: UIImage?
    
    @State
    private var isLoading = false
    
    var body: some View {
        ZStack {
            if let uiImage{
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                placeholderImage
                    .resizable()
                    .aspectRatio(contentMode: .fill)
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
        if let cachedImage = PDImageDownloader.imageCache.object(forKey: url as NSURL) {
            self.uiImage = cachedImage
            return
        }
        
        isLoading = true
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            guard let data, let downloadedImage = UIImage(data: data) else {
                return
            }
            
            PDImageDownloader.imageCache.setObject(downloadedImage, forKey: url as NSURL)
            
            DispatchQueue.main.async {
                self.uiImage = downloadedImage
            }
            
        }
        .resume()
    }
}
