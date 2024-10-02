//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import Foundation

struct Pokemon: Codable, Identifiable, Equatable {
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: Int
    let name: String
    let images: [Image]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case images = "sprites"
    }
}

extension Pokemon {
    struct Image: Codable {
        let frontalURL: URL

        enum CodingKeys: String, CodingKey {
            case frontalURL = "front_default"
        }
    }
}
