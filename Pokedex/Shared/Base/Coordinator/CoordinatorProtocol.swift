//
//  CoordinatorProtocol.swift
//  Pokedex
//
//  Created by Savyo Brenner on 01/10/24.
//

import SwiftUI

protocol CoordinatorProtocol: AnyObject {
    associatedtype ContentView: View
    func start() -> ContentView
    func present<PresentedView: View>(_ view: PresentedView)
    func pop()
}
