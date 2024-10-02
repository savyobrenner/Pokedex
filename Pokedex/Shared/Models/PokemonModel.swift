//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Savyo Brenner on 02/10/24.
//

import Foundation

struct Pokemon: Codable {
    let abilities: [Ability]?
    let baseExperience: Int?
    let height: Int?
    let id: Int
    let name: String
    let species: Species?
    let images: Images?
    let stats: [Stat]?
    let types: [TypeElement]?
    let weight: Int?
    
    enum CodingKeys: String, CodingKey {
        case abilities
        case baseExperience = "base_experience"
        case height
        case id
        case name
        case species
        case images = "sprites"
        case stats, types, weight
    }
}

extension Pokemon {
    struct Ability: Codable {
        let ability: Species?
        let isHidden: Bool?
        let slot: Int?
        
        enum CodingKeys: String, CodingKey {
            case ability
            case isHidden = "is_hidden"
            case slot
        }
    }
    
    struct Species: Codable {
        let name: String?
        let url: String?
    }
    
    struct Stat: Codable {
        let baseStat, effort: Int?
        let stat: Species?
        
        enum CodingKeys: String, CodingKey {
            case baseStat = "base_stat"
            case effort, stat
        }
    }
    
    struct TypeElement: Codable {
        let slot: Int?
        let type: Species?
    }
    
    struct Images: Codable {
        let backDefault: URL?
        let backFemale: URL?
        let backShiny: URL?
        let backShinyFemale: URL?
        let frontDefault: URL?
        let frontFemale: URL?
        let frontShiny: URL?
        let frontShinyFemale: URL?
        
        enum CodingKeys: String, CodingKey {
            case backDefault = "back_default"
            case backFemale = "back_female"
            case backShiny = "back_shiny"
            case backShinyFemale = "back_shiny_female"
            case frontDefault = "front_default"
            case frontFemale = "front_female"
            case frontShiny = "front_shiny"
            case frontShinyFemale = "front_shiny_female"
        }
    }
}
