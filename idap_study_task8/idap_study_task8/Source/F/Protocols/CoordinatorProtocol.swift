//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

public protocol Coordinator: AnyObject {
    
    var navigationViewController: UINavigationController { get set }
    
    func presentAlert(alertModel: AlertModel, controller: UIViewController?)
}

extension Coordinator {
    
    public func presentAlert(alertModel: AlertModel, controller: UIViewController? = nil) {
        let presenter = controller ?? self.navigationViewController
        let alert = UIAlertController(title: alertModel.title, message: alertModel.message, preferredStyle: .alert)
        if !alertModel.actions.isEmpty {
            alertModel.actions.forEach {
                alert.addAction($0)
            }
        } else {
            alert.addAction(UIAlertAction(title: "ок", style: .cancel))
        }
        
        presenter.present(alert, animated: true)
    }
}
