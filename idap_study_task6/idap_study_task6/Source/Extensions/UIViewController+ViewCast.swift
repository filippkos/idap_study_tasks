import UIKit

extension UIViewController {
    func view<T: UIView>() -> T? {
        return self.view as? T
    }
}
