//
//  NetworkProtocol.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

protocol NetworkProtocol {
    func sendRequest<Response: Decodable>(
        endpoint: Endpoint,
        responseModel: Response.Type
    ) async throws -> Response
}
