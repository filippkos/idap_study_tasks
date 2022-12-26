//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

struct PokemonCellData {
    
    // MARK: -
    // MARK: Variables
    
    let name: String
    var image: UIImage?
    var handler: ((UIImage) -> ())?
}
