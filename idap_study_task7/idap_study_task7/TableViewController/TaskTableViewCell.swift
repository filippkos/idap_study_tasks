import UIKit

class TaskTableViewCell: UITableViewCell {
    
    // MARK: -
    // MARK: IBOutlets
    
    @IBOutlet var label: UILabel?
    @IBOutlet var logo: UIImageView?
    @IBOutlet var spinner: UIActivityIndicatorView?
    
    // MARK: -
    // MARK: Variables
    
    private(set) var id = UUID()
    
    // MARK: -
    // MARK: Private
    
    public func fill(number: Int) {
        self.label?.text = number.description
    }
    
    public func fill(word: NSMutableAttributedString) {
        self.label?.attributedText = word
    }
    
    func add(logo: UIImage?) {
        self.logo?.image = logo
    }
    
    // MARK: -
    // MARK: Overrided

    override func prepareForReuse() {
        super.prepareForReuse()
        self.id = UUID()
        self.label?.text = "Label"
    }
}
