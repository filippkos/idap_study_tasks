import Foundation

// MARK: - Empty
struct PokemonList: Codable {
    
    let count: Int
    let next: String
    let previous: String?
    let results: [Unit]
}

// MARK: - Unit
struct Unit: Codable {
    
    let name: String
    let url: String
}


