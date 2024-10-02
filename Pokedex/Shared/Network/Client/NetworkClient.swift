//
//  NetworkClient.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import Foundation

final class NetworkClient: NetworkProtocol {
    private let urlSession: URLSession

    init(session: URLSession = .shared) {
        self.urlSession = session
    }

    func sendRequest<Response: Decodable>(endpoint: Endpoint, responseModel: Response.Type) async throws -> Response {
        let request = try prepareRequest(for: endpoint)
        return try await send(request: request, responseModel: responseModel)
    }

    func sendRequest<Response: Decodable>(url: URL, responseModel: Response.Type) async throws -> Response {
        let request = URLRequest(url: url)
        return try await send(request: request, responseModel: responseModel)
    }

    private func send<Response: Decodable>(request: URLRequest, responseModel: Response.Type) async throws -> Response {
        do {
            let (data, response) = try await urlSession.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw AppError.invalidResponse
            }

            switch httpResponse.statusCode {
            case 200...299:
                return try JSONDecoder().decode(responseModel, from: data)
            default:
                throw AppError.statusCode(httpResponse.statusCode)
            }
        } catch let error as URLError {
            throw AppError.urlError(error)
        } catch {
            throw AppError.unknown
        }
    }

    private func prepareRequest(for endpoint: Endpoint) throws -> URLRequest {
        guard let url = endpoint.url else {
            throw AppError.invalidURL
        }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = endpoint.queryParameters.isEmpty ? nil : endpoint.queryParameters

        guard let finalURL = components?.url else {
            throw AppError.invalidURL
        }

        var request = URLRequest(url: finalURL)
        request.httpMethod = endpoint.request.methodName
        endpoint.requestSpecificHeaders.forEach { request.addValue($1, forHTTPHeaderField: $0) }
        return request
    }
}
