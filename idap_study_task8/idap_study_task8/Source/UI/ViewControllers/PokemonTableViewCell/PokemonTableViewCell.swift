//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

class PokemonTableViewCell: UITableViewCell {

    // MARK: -
    // MARK: Outlets
    
    @IBOutlet internal var parameterLabel: UILabel?
    
    // MARK: -
    // MARK: Variables
    
    private(set) var id = UUID()
    
    // MARK: -
    // MARK: Public
    
    public func fill(text: String) {
        self.parameterLabel?.text = text
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.id = UUID()
    }
}
