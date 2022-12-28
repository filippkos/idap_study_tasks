//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

class PokemonListTableViewCell: UITableViewCell {

    // MARK: -
    // MARK: Outlets
    
    @IBOutlet internal var parameterLabel: UILabel?
    @IBOutlet internal var viewedIcon: UIImageView?
    
    // MARK: -
    // MARK: Public
    
    public func fill(text: String) {
        self.parameterLabel?.text = text
    }
    
    public func fill(image: UIImage) {
        self.viewedIcon?.image = image
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.viewedIcon?.image = nil
    }
}
