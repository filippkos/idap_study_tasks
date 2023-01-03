//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

final class PokemonView: BaseView {
    
    // MARK: -
    // MARK: Outlets
    
    @IBOutlet internal var tableView: UITableView?
    @IBOutlet internal var nameLabel: UILabel?
    @IBOutlet internal var imageView: UIImageView?
    
    // MARK: -
    // MARK: Public
    
    public func set(image: UIImage) {
        self.imageView?.image = image
    }
}
