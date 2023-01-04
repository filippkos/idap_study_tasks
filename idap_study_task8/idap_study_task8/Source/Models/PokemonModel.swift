//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

struct PokemonModel {
    
    // MARK: -
    // MARK: Variables
    
    var uid = UUID().uuidString
    let name: String
    var image: UIImage?
    var checkMark: UIImage?
    var handler: ((UIImage) -> ())?
}

extension PokemonModel: Hashable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.uid == rhs.uid
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(uid)
    }
}
