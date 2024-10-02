//
//  NetworkProtocol.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import Foundation

protocol NetworkProtocol {
    func sendRequest<Response: Decodable>(
        endpoint: Endpoint,
        responseModel: Response.Type
    ) async throws -> Response

    func sendRequest<Response: Decodable>(
        url: URL,
        responseModel: Response.Type
    ) async throws -> Response
}
