import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet internal var parameterLabel: UILabel?
    
    public func fill(text: String) {
        self.parameterLabel?.text = text
    }
}
