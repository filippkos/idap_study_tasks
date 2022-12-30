//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

struct PokemonModel: Equatable {
    
    // MARK: -
    // MARK: Variables
    
    let name: String
    var image: UIImage?
    var handler: ((UIImage) -> ())?
    
    // MARK: -
    // MARK: Static
    
    static func == (lhs: PokemonModel, rhs: PokemonModel) -> Bool {
            lhs.name == rhs.name &&
            lhs.image == rhs.image
    }
}
