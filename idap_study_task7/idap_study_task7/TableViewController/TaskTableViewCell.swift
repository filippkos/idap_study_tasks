import UIKit

class TaskTableViewCell: UITableViewCell {
    
    // MARK: -
    // MARK: IBOutlets
    
    @IBOutlet var label: UILabel?
    
    // MARK: -
    // MARK: Private
    
    public func fill(number: Int) {
        self.label?.text = number.description
    }
    
    public func fill(word: String) {
        self.label?.text = word.description
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
