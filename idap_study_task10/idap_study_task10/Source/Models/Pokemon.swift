//
//  Pokemon.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
//

import UIKit

// MARK: - Pokemon
struct Pokemon: Codable {
    
    var image: UIImage?
    var checkMark: UIImage?
    
    let id: Int
    let name: String
    let baseExperience: Int
    let height: Int
    let isDefault: Bool
    let order, weight: Int?
    let abilities: [Ability]?
    let forms: [TestModel]?
    let heldItems: [HeldItem]?
    let moves: [Move]?
    let species: TestModel?
    let sprites: Sprites?
    let stats: [Stat]?
    let types: [TypeElement]?
    
    enum CodingKeys: String, CodingKey {
        
        case id, name
        case baseExperience = "base_experience"
        case height
        case isDefault = "is_default"
        case order, weight, abilities, forms
        case heldItems = "held_items"
        case moves, species, sprites, stats, types
    }
    
    var grouped: [Int: (String ,[String])] {
        [
            0 : ("Id", [self.id.description]),
            1 : ("Name", [self.name.description]),
            2 : ("Base experience", [self.baseExperience.description]),
            3 : ("Height", [self.height.description]),
            4 : ("Weight", [self.weight?.description ?? ""]),
            5 : ("Is default", [self.isDefault.description]),
            6 : ("Order", [self.order?.description ?? ""]),
            7 : ("Abilities", self.abilities?.map(\.ability.name) ?? []),
            8 : ("Forms", self.forms?.map(\.name) ?? []),
            9 : ("Held Items", self.heldItems?.map(\.item.name) ?? []),
            10 : ("Moves", self.moves?.map(\.move.name) ?? []),
            11 : ("Species", [self.species?.name ?? ""]),
            12 : ("Stats", self.stats?.map(\.stat.name) ?? []),
            13 : ("Types", self.types?.map(\.type.name.rawValue) ?? [])
        ]
    }
}

// MARK: - Ability
struct Ability: Codable {
    
    let isHidden: Bool
    let slot: Int
    let ability: TestModel

    enum CodingKeys: String, CodingKey {
        
        case isHidden = "is_hidden"
        case slot, ability
    }
}

// MARK: - ?
struct TestModel: Codable {
    
    let name: String
    let url: String
}

// MARK: - Species
struct Species: Codable {
    
    let name: PokemonType
    let url: String
}

// MARK: - HeldItem
struct HeldItem: Codable {
    
    let item: TestModel
    let versionDetails: [VersionDetail]

    enum CodingKeys: String, CodingKey {
        
        case item
        case versionDetails = "version_details"
    }
}

// MARK: - VersionDetail
struct VersionDetail: Codable {
    
    let rarity: Int
    let version: TestModel
}

// MARK: - Move
struct Move: Codable {
    
    let move: TestModel
    let versionGroupDetails: [VersionGroupDetail]

    enum CodingKeys: String, CodingKey {
        
        case move
        case versionGroupDetails = "version_group_details"
    }
}

// MARK: - VersionGroupDetail
struct VersionGroupDetail: Codable {
    
    let levelLearnedAt: Int
    let versionGroup: TestModel
    let moveLearnMethod: TestModel

    enum CodingKeys: String, CodingKey {
        
        case levelLearnedAt = "level_learned_at"
        case versionGroup = "version_group"
        case moveLearnMethod = "move_learn_method"
    }
}

// MARK: - TypeElement
struct TypeElement: Codable {
    
    let slot: Int
    let type: Species
}

// MARK: - Sprites
struct Sprites: Codable {
    let backDefault: String?
    let backShiny: String?
    let frontDefault: String?
    let frontShiny: String?
    
    var frontDefaultEncoded: String {
        return frontDefault?.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? ""
    }
    
    enum CodingKeys: String, CodingKey {
        
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}

// MARK: - RedBlue
struct RedBlue: Codable {
    
    let backDefault, backGray, frontDefault, frontGray: String

    enum CodingKeys: String, CodingKey {
        
        case backDefault = "back_default"
        case backGray = "back_gray"
        case frontDefault = "front_default"
        case frontGray = "front_gray"
    }
}


// MARK: - OfficialArtwork
struct OfficialArtwork: Codable {
    
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        
        case frontDefault = "front_default"
    }
}

// MARK: - Stat
struct Stat: Codable {
    
    let baseStat, effort: Int
    let stat: TestModel

    enum CodingKeys: String, CodingKey {
        
        case baseStat = "base_stat"
        case effort, stat
    }
}
