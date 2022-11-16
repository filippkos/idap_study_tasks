import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(cellClass: T.Type) {
        let className = String(describing: T.self)
        let nib: UINib = UINib(nibName: className, bundle: .main)
        self.register(nib, forCellReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(cellClass: T.Type) -> T {
        let className = String(describing: T.self)
        let cell = self.dequeueReusableCell(withIdentifier: className) as? T
        guard let cell = cell else {
            fatalError("this cell type doesn't registered")
        }
        return cell
    }
}  
