//
//  TypeListResponse.swift
//  Pokedex
//
//  Created by Savyo Brenner on 03/10/24.
//

import Foundation

struct TypeListResponse: Codable {
    let count: Int
    let next: URL?
    let results: [TypeData]

    struct TypeData: Codable {
        let name: String
        let url: String
    }
}
