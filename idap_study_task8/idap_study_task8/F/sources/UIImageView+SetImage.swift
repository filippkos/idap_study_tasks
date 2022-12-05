import UIKit

extension UIImageView {
    
public func setImage(from url: String?) {
    NetworkManager.shared.getImage(
        from: url ?? "",
        completion: { [weak self] image in
            self?.image = image
        }
    )
    }
}
