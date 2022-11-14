import UIKit

class TaskTableViewCell: UITableViewCell {
    
    // MARK: -
    // MARK: IBOutlets
    
    @IBOutlet var label: UILabel?
    @IBOutlet var logo: UIImageView!
    
    // MARK: -
    // MARK: Private
    
    public func fill(number: Int) {
        self.label?.text = number.description
    }
    
    public func fill(word: NSMutableAttributedString) {
        self.label?.attributedText = word
    }
    
    func add(logo: UIImage?) {
        self.logo.image = logo
    }
    
    // MARK: -
    // MARK: Overrided

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
