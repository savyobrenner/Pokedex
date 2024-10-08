//
//  SplashViewModelProtocol.swift
//  Pokedex
//
//  Created by Savyo Brenner on 01/10/24.
//

import Foundation

protocol SplashViewModelProtocol: ObservableObject {
    var ballOffset: CGSize { get set }
    var textOpacity: Double { get set }
    func onLoad()
}
