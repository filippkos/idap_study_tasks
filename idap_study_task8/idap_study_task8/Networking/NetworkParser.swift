import UIKit

class NetworkParser {
    
    func image(from data: Data) -> UIImage {
        var result = UIImage()
        if let image = UIImage(data: data) {
            result = image
        }
        
        return result
    }
}
