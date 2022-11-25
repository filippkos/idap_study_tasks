import Foundation

// MARK: - TopLevel
class TopLevel: Codable, ModelPropertyContent {
    
    let id: Int
    let name: String
    let baseExperience, height: Int
    let isDefault: Bool
    let order, weight: Int
    let abilities: [Ability]
    let forms: [Species]
    let gameIndices: [GameIndex]
    let heldItems: [HeldItem]
    let locationAreaEncounters: String
    let moves: [Move]
    let species: Species
    let sprites: Sprites
    let stats: [Stat]
    let types: [TypeElement]
    let pastTypes: [PastType]

    enum CodingKeys: String, CodingKey {
        
        case id, name
        case baseExperience = "base_experience"
        case height
        case isDefault = "is_default"
        case order, weight, abilities, forms
        case gameIndices = "game_indices"
        case heldItems = "held_items"
        case locationAreaEncounters = "location_area_encounters"
        case moves, species, sprites, stats, types
        case pastTypes = "past_types"
    }

    init(id: Int, name: String, baseExperience: Int, height: Int, isDefault: Bool, order: Int, weight: Int, abilities: [Ability], forms: [Species], gameIndices: [GameIndex], heldItems: [HeldItem], locationAreaEncounters: String, moves: [Move], species: Species, sprites: Sprites, stats: [Stat], types: [TypeElement], pastTypes: [PastType]) {
        self.id = id
        self.name = name
        self.baseExperience = baseExperience
        self.height = height
        self.isDefault = isDefault
        self.order = order
        self.weight = weight
        self.abilities = abilities
        self.forms = forms
        self.gameIndices = gameIndices
        self.heldItems = heldItems
        self.locationAreaEncounters = locationAreaEncounters
        self.moves = moves
        self.species = species
        self.sprites = sprites
        self.stats = stats
        self.types = types
        self.pastTypes = pastTypes
    }
}

// MARK: - Ability
class Ability: Codable {
    
    let isHidden: Bool
    let slot: Int
    let ability: Species

    enum CodingKeys: String, CodingKey {
        
        case isHidden = "is_hidden"
        case slot, ability
    }

    init(isHidden: Bool, slot: Int, ability: Species) {
        self.isHidden = isHidden
        self.slot = slot
        self.ability = ability
    }
}

// MARK: - Species
class Species: Codable {
    
    let name: String
    let url: String

    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}

// MARK: - GameIndex
class GameIndex: Codable {
    
    let gameIndex: Int
    let version: Species

    enum CodingKeys: String, CodingKey {
        
        case gameIndex = "game_index"
        case version
    }

    init(gameIndex: Int, version: Species) {
        self.gameIndex = gameIndex
        self.version = version
    }
}

// MARK: - HeldItem
class HeldItem: Codable {
    
    let item: Species
    let versionDetails: [VersionDetail]

    enum CodingKeys: String, CodingKey {
        
        case item
        case versionDetails = "version_details"
    }

    init(item: Species, versionDetails: [VersionDetail]) {
        self.item = item
        self.versionDetails = versionDetails
    }
}

// MARK: - VersionDetail
class VersionDetail: Codable {
    
    let rarity: Int
    let version: Species

    init(rarity: Int, version: Species) {
        self.rarity = rarity
        self.version = version
    }
}

// MARK: - Move
class Move: Codable {
    
    let move: Species
    let versionGroupDetails: [VersionGroupDetail]

    enum CodingKeys: String, CodingKey {
        
        case move
        case versionGroupDetails = "version_group_details"
    }

    init(move: Species, versionGroupDetails: [VersionGroupDetail]) {
        self.move = move
        self.versionGroupDetails = versionGroupDetails
    }
}

// MARK: - VersionGroupDetail
class VersionGroupDetail: Codable {
    
    let levelLearnedAt: Int
    let versionGroup, moveLearnMethod: Species

    enum CodingKeys: String, CodingKey {
        
        case levelLearnedAt = "level_learned_at"
        case versionGroup = "version_group"
        case moveLearnMethod = "move_learn_method"
    }

    init(levelLearnedAt: Int, versionGroup: Species, moveLearnMethod: Species) {
        self.levelLearnedAt = levelLearnedAt
        self.versionGroup = versionGroup
        self.moveLearnMethod = moveLearnMethod
    }
}

// MARK: - PastType
class PastType: Codable {
    
    let generation: Species
    let types: [TypeElement]

    init(generation: Species, types: [TypeElement]) {
        self.generation = generation
        self.types = types
    }
}

// MARK: - TypeElement
class TypeElement: Codable {
    
    let slot: Int
    let type: Species

    init(slot: Int, type: Species) {
        self.slot = slot
        self.type = type
    }
}

// MARK: - GenerationV
class GenerationV: Codable {
    let blackWhite: Sprites

    enum CodingKeys: String, CodingKey {
        case blackWhite = "black-white"
    }

    init(blackWhite: Sprites) {
        self.blackWhite = blackWhite
    }
}

// MARK: - GenerationIv
class GenerationIv: Codable {
    let diamondPearl, heartgoldSoulsilver, platinum: Sprites

    enum CodingKeys: String, CodingKey {
        case diamondPearl = "diamond-pearl"
        case heartgoldSoulsilver = "heartgold-soulsilver"
        case platinum
    }

    init(diamondPearl: Sprites, heartgoldSoulsilver: Sprites, platinum: Sprites) {
        self.diamondPearl = diamondPearl
        self.heartgoldSoulsilver = heartgoldSoulsilver
        self.platinum = platinum
    }
}

// MARK: - Versions
class Versions: Codable {
    
    let generationI: GenerationI
    let generationIi: GenerationIi
    let generationIii: GenerationIii
    let generationIv: GenerationIv
    let generationV: GenerationV
    let generationVi: [String: Home]
    let generationVii: GenerationVii
    let generationViii: GenerationViii

    enum CodingKeys: String, CodingKey {
        case generationI = "generation-i"
        case generationIi = "generation-ii"
        case generationIii = "generation-iii"
        case generationIv = "generation-iv"
        case generationV = "generation-v"
        case generationVi = "generation-vi"
        case generationVii = "generation-vii"
        case generationViii = "generation-viii"
    }

    init(generationI: GenerationI, generationIi: GenerationIi, generationIii: GenerationIii, generationIv: GenerationIv, generationV: GenerationV, generationVi: [String: Home], generationVii: GenerationVii, generationViii: GenerationViii) {
        self.generationI = generationI
        self.generationIi = generationIi
        self.generationIii = generationIii
        self.generationIv = generationIv
        self.generationV = generationV
        self.generationVi = generationVi
        self.generationVii = generationVii
        self.generationViii = generationViii
    }
}

// MARK: - Sprites
class Sprites: Codable {
    
    let backDefault: String
    let backFemale: JSONNull?
    let backShiny: String
    let backShinyFemale: JSONNull?
    let frontDefault: String
    let frontFemale: JSONNull?
    let frontShiny: String
    let frontShinyFemale: JSONNull?
    let other: Other?
    let versions: Versions?
    let animated: Sprites?

    enum CodingKeys: String, CodingKey {
        
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
        case other, versions, animated
    }

    init(backDefault: String, backFemale: JSONNull?, backShiny: String, backShinyFemale: JSONNull?, frontDefault: String, frontFemale: JSONNull?, frontShiny: String, frontShinyFemale: JSONNull?, other: Other?, versions: Versions?, animated: Sprites?) {
        self.backDefault = backDefault
        self.backFemale = backFemale
        self.backShiny = backShiny
        self.backShinyFemale = backShinyFemale
        self.frontDefault = frontDefault
        self.frontFemale = frontFemale
        self.frontShiny = frontShiny
        self.frontShinyFemale = frontShinyFemale
        self.other = other
        self.versions = versions
        self.animated = animated
    }
}

// MARK: - GenerationI
class GenerationI: Codable {
    let redBlue, yellow: RedBlue

    enum CodingKeys: String, CodingKey {
        case redBlue = "red-blue"
        case yellow
    }

    init(redBlue: RedBlue, yellow: RedBlue) {
        self.redBlue = redBlue
        self.yellow = yellow
    }
}

// MARK: - RedBlue
class RedBlue: Codable {
    let backDefault, backGray, frontDefault, frontGray: String

    enum CodingKeys: String, CodingKey {
        
        case backDefault = "back_default"
        case backGray = "back_gray"
        case frontDefault = "front_default"
        case frontGray = "front_gray"
    }

    init(backDefault: String, backGray: String, frontDefault: String, frontGray: String) {
        self.backDefault = backDefault
        self.backGray = backGray
        self.frontDefault = frontDefault
        self.frontGray = frontGray
    }
}

// MARK: - GenerationIi
class GenerationIi: Codable {
    
    let crystal, gold, silver: Crystal

    init(crystal: Crystal, gold: Crystal, silver: Crystal) {
        self.crystal = crystal
        self.gold = gold
        self.silver = silver
    }
}

// MARK: - Crystal
class Crystal: Codable {
    let backDefault, backShiny, frontDefault, frontShiny: String

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

// MARK: - GenerationIii
class GenerationIii: Codable {
    
    let emerald: Emerald
    let fireredLeafgreen, rubySapphire: Crystal

    enum CodingKeys: String, CodingKey {
        
        case emerald
        case fireredLeafgreen = "firered-leafgreen"
        case rubySapphire = "ruby-sapphire"
    }

    init(emerald: Emerald, fireredLeafgreen: Crystal, rubySapphire: Crystal) {
        self.emerald = emerald
        self.fireredLeafgreen = fireredLeafgreen
        self.rubySapphire = rubySapphire
    }
}

// MARK: - Emerald
class Emerald: Codable {
    let frontDefault, frontShiny: String

    enum CodingKeys: String, CodingKey {
        
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }

    init(frontDefault: String, frontShiny: String) {
        self.frontDefault = frontDefault
        self.frontShiny = frontShiny
    }
}

// MARK: - Home
class Home: Codable {
    
    let frontDefault: String
    let frontFemale: JSONNull?
    let frontShiny: String
    let frontShinyFemale: JSONNull?

    enum CodingKeys: String, CodingKey {
        
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }

    init(frontDefault: String, frontFemale: JSONNull?, frontShiny: String, frontShinyFemale: JSONNull?) {
        self.frontDefault = frontDefault
        self.frontFemale = frontFemale
        self.frontShiny = frontShiny
        self.frontShinyFemale = frontShinyFemale
    }
}

// MARK: - GenerationVii
class GenerationVii: Codable {
    
    let icons: DreamWorld
    let ultraSunUltraMoon: Home

    enum CodingKeys: String, CodingKey {
        
        case icons
        case ultraSunUltraMoon = "ultra-sun-ultra-moon"
    }

    init(icons: DreamWorld, ultraSunUltraMoon: Home) {
        self.icons = icons
        self.ultraSunUltraMoon = ultraSunUltraMoon
    }
}

// MARK: - DreamWorld
class DreamWorld: Codable {
    
    let frontDefault: String
    let frontFemale: JSONNull?

    enum CodingKeys: String, CodingKey {
        
        case frontDefault = "front_default"
        case frontFemale = "front_female"
    }

    init(frontDefault: String, frontFemale: JSONNull?) {
        self.frontDefault = frontDefault
        self.frontFemale = frontFemale
    }
}

// MARK: - GenerationViii
class GenerationViii: Codable {
    
    let icons: DreamWorld

    init(icons: DreamWorld) {
        self.icons = icons
    }
}

// MARK: - Other
class Other: Codable {
    
    let dreamWorld: DreamWorld
    let home: Home
    let officialArtwork: OfficialArtwork

    enum CodingKeys: String, CodingKey {
        
        case dreamWorld = "dream_world"
        case home
        case officialArtwork = "official-artwork"
    }

    init(dreamWorld: DreamWorld, home: Home, officialArtwork: OfficialArtwork) {
        self.dreamWorld = dreamWorld
        self.home = home
        self.officialArtwork = officialArtwork
    }
}

// MARK: - OfficialArtwork
class OfficialArtwork: Codable {
    
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        
        case frontDefault = "front_default"
    }

    init(frontDefault: String) {
        self.frontDefault = frontDefault
    }
}

// MARK: - Stat
class Stat: Codable {
    
    let baseStat, effort: Int
    let stat: Species

    enum CodingKeys: String, CodingKey {
        
        case baseStat = "base_stat"
        case effort, stat
    }

    init(baseStat: Int, effort: Int, stat: Species) {
        self.baseStat = baseStat
        self.effort = effort
        self.stat = stat
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

