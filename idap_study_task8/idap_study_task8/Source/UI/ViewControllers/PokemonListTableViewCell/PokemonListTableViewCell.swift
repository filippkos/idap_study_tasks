//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

struct PokemonListTableViewCellModel {
    
    let text: String
    let image: UIImage?
}

class PokemonListTableViewCell: UITableViewCell {

    // MARK: -
    // MARK: Outlets
    
    @IBOutlet internal var parameterLabel: UILabel?
    @IBOutlet internal var viewedIcon: UIImageView?
    
    // MARK: -
    // MARK: Public
    
    public func fill(with model: PokemonListTableViewCellModel) {
        self.parameterLabel?.text = model.text
        self.viewedIcon?.image = model.image
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.viewedIcon?.image = nil
    }
}
