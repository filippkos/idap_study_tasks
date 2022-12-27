//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

struct PokemonModel {
    
    let name: String
    var image: UIImage?
    var handler: ((UIImage) -> ())?
}
