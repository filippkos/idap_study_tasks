//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

final class PokemonView: UIView, Spinnable {
    
    // MARK: -
    // MARK: Typealiases
    
    typealias SpinnerType = SpinnerView
    
    // MARK: -
    // MARK: Variables
    
    var isLoaded: Bool = true
    
    // MARK: -
    // MARK: Outlets
    
    @IBOutlet internal var tableView: UITableView?
    @IBOutlet internal var nameLabel: UILabel?
    @IBOutlet internal var imageView: UIImageView?
}
