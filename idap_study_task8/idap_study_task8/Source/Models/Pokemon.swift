//Created for idap_study_task8 in 2022
// Using Swift 5.0

import Foundation
import UIKit

extension Pokemon: Hashable, Comparable {
    
    static func < (lhs: Pokemon, rhs: Pokemon) -> Bool {
        lhs.uid < rhs.uid
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.uid == rhs.uid
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(uid)
    }
}

// MARK: - Pokemon
struct Pokemon: Codable {
    

    let id: Int
    let name: String
    let baseExperience: Int = 0
    let height: Int
    let isDefault: Bool
    let order, weight: Int
    let abilities: [Ability]
    let forms: [Species]
    let heldItems: [HeldItem]
    let moves: [Move]
    let species: Species
    let sprites: Sprites
    let stats: [Stat]
    let types: [TypeElement]
    var uid = UUID().uuidString
    var image: UIImage?
    var checkMark: UIImage?

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
         0 : ("Id", [id.description]),
         1 : ("Name", [name.description]),
         2 : ("Base experiemce", [baseExperience.description]),
         3 : ("Height", [height.description]),
         4 : ("Is default", [isDefault.description]),
         5 : ("Order", [order.description]),
         6 : ("Weight", [weight.description]),
         7 : ("Abilities", abilities.map(\.ability.name)),
         8 : ("Forms", forms.map(\.name)),
         9 : ("Held Items", heldItems.map(\.item.name)),
         10 : ("Moves", moves.map(\.move.name)),
         11 : ("Species", [species.name]),
         12 : ("Sprites", [sprites.frontShiny]),
         13 : ("Stats", stats.map(\.stat.name)),
         14 : ("Types", types.map(\.type.name))
        ]
    }
}

// MARK: - Ability
struct Ability: Codable {
    
    let isHidden: Bool
    let slot: Int
    let ability: Species

    enum CodingKeys: String, CodingKey {
        
        case isHidden = "is_hidden"
        case slot, ability
    }
}

// MARK: - Species
struct Species: Codable {
    
    let name: String
    let url: String
}

// MARK: - HeldItem
struct HeldItem: Codable {
    
    let item: Species
    let versionDetails: [VersionDetail]

    enum CodingKeys: String, CodingKey {
        
        case item
        case versionDetails = "version_details"
    }
}

// MARK: - VersionDetail
struct VersionDetail: Codable {
    
    let rarity: Int
    let version: Species
}

// MARK: - Move
struct Move: Codable {
    
    let move: Species
    let versionGroupDetails: [VersionGroupDetail]

    enum CodingKeys: String, CodingKey {
        
        case move
        case versionGroupDetails = "version_group_details"
    }
}

// MARK: - VersionGroupDetail
struct VersionGroupDetail: Codable {
    
    let levelLearnedAt: Int
    let versionGroup, moveLearnMethod: Species

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
class Sprites: Codable {
    let backDefault: String
    let backShiny: String
    let frontDefault: String
    let frontShiny: String

    enum CodingKeys: String, CodingKey {
        
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }

    init(backDefault: String, backShiny: String, frontDefault: String, frontShiny: String) {
        self.backDefault = backDefault

        self.backShiny = backShiny

        self.frontDefault = frontDefault

        self.frontShiny = frontShiny
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
    let stat: Species

    enum CodingKeys: String, CodingKey {
        
        case baseStat = "base_stat"
        case effort, stat
    }
}
