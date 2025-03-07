//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

class PokemonListTableViewCell: UITableViewCell, Spinnable {
    
    // MARK: -
    // MARK: Typealiases
    
    typealias SpinnerType = SpinnerView
    
    // MARK: -
    // MARK: Variables
    
    var isLoaded: Bool = false
    private(set) var id = UUID()
    
    // MARK: -
    // MARK: Outlets
    
    @IBOutlet internal var parameterLabel: UILabel?
    @IBOutlet internal var viewedIcon: UIImageView?
    @IBOutlet internal var pokemonIcon: UIImageView?
    
    // MARK: -
    // MARK: Public
    
    func configure(with model: Pokemon, image: UIImage) {
        self.parameterLabel?.text = model.name
        self.viewedIcon?.image = model.checkMark
        self.pokemonIcon?.image = image
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.viewedIcon?.image = nil
        self.pokemonIcon?.image = nil
        self.parameterLabel?.text = nil
        self.id = UUID()
    }
}
