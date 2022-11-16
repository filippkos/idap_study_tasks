import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet var label: UILabel?
    
    public func fill(string: String) {
        self.label?.text = string.description
    }
}
