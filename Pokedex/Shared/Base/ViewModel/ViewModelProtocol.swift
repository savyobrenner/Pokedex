//
//  ViewModelProtocol.swift
//  Pokedex
//
//  Created by Savyo Brenner on 01/10/24.
//

import SwiftUI

protocol ViewModelProtocol: ObservableObject {
    associatedtype CoordinatorType: CoordinatorProtocol
    var coordinator: CoordinatorType { get }
    func onAppear()
}
