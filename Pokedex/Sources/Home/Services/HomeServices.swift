//
//  HomeService.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import Foundation

final class HomeServices: HomeServicesProtocol {
    private let network: NetworkProtocol

    init(network: NetworkProtocol = NetworkClient()) {
        self.network = network
    }

    func loadHome() async throws -> String {
        let response = try await network.sendRequest(endpoint: HomeEndpoint.loadHome, responseModel: String.self)

        return response
    }
}

