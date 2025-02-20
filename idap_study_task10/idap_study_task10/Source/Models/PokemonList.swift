//
//  PokemonList.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
//

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

