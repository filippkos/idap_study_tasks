import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet var dayOfTheWeekLabel: UILabel?
    @IBOutlet var dayOfTheMonthLabel: UILabel?
    @IBOutlet var daytimeTemperatureLabel: UILabel?
    @IBOutlet var nightTemperatureLabel: UILabel?
    @IBOutlet var weatherStateImage: UIImageView?
    @IBOutlet var humidityLabel: UILabel?
}
