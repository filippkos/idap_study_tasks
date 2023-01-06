//Created for idap_study_task8 in 2022
// Using Swift 5.0

import Foundation

// MARK: - PokemonList
struct PokemonList: Codable {
    
    let count: Int
    let next: String?
    let previous: String?
    let results: [Unit]
}

// MARK: - Unit
struct Unit: Codable {
    
    let name: String
    let url: String
}


