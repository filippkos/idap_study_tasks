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
    private lazy var imageService = ImageService()
    private var onReuse: ((URLSessionDataTask?) -> ())?
    
    // MARK: -
    // MARK: Outlets
    
    @IBOutlet internal var parameterLabel: UILabel?
    @IBOutlet internal var viewedIcon: UIImageView?
    @IBOutlet internal var pokemonIcon: UIImageView?
    
    // MARK: -
    // MARK: Public
    
    func configure(with model: Pokemon, completion: @escaping (Error?) -> ()) {
        self.parameterLabel?.text = model.name
        self.viewedIcon?.image = model.checkMark
        
        self.imageService.image(for: model) { [weak self] image in
            self?.pokemonIcon?.image = image
        } taskHandler: { task in
            self.onReuse?(task)
        } alertHandler: { error in
            completion(error)
        }
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.onReuse = { task in
            task?.cancel()
        }
        self.viewedIcon?.image = nil
    }
}
