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
    
    public func fill(word: NSMutableAttributedString) {
        self.label?.attributedText = word
    }
    
    func addImage() {
        let cellImage = UIImage(named:"logoimage.png")
        let cellHeight = self.frame.size.height
        self.imageView?.image = cellImage?.compress(cellHeight: cellHeight)
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
