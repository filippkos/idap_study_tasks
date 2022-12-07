import UIKit

final class PokemonView: UIView {

    // MARK: -
    // MARK: Outlets
    
    @IBOutlet internal var searchBar: UISearchBar?
    @IBOutlet internal var tableView: UITableView?
    @IBOutlet internal var nameLabel: UILabel?
    @IBOutlet internal var imageView: UIImageView?
    @IBOutlet var spinner: UIActivityIndicatorView?
    @IBOutlet var placeHolderLabel: UILabel?
}
 
