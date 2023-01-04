//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

final class PokemonView: BaseView {
    
    // MARK: -
    // MARK: Outlets
    
    @IBOutlet internal var tableView: UITableView?
    @IBOutlet internal var nameLabel: UILabel?
    @IBOutlet internal var imageView: UIImageView?
    @IBOutlet internal var imageContainer: UIView?
    // MARK: -
    // MARK: Public
    
    public func set(image: UIImage, text: String) {
        self.imageView?.image = image
        self.nameLabel?.text = text
    }
    
}
