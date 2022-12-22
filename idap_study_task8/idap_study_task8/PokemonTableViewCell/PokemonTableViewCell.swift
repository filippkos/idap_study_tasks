//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet internal var parameterLabel: UILabel?
    
    public func fill(text: String) {
        self.parameterLabel?.text = text
    }
}
