//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

public struct AlertModel {
    
    let title: String
    let message: String
    // в этой модели должна быть возможность передать виды кнопок + действия на них(комплишены)
}

public protocol Coordinator: AnyObject {
    
    var navigationViewController: UINavigationController { get set }
    
    func presentAlert(alertModel: AlertModel, controller: UIViewController?)
}

extension Coordinator {
    
    public func presentAlert(alertModel: AlertModel, controller: UIViewController? = nil) {
        let presenter = controller ?? self.navigationViewController
        let alert = UIAlertController(title: alertModel.title, message: alertModel.message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ок", style: .cancel)
        alert.addAction(action)

        presenter.present(alert, animated: true)
    }
    
    public func alertModel(error: Error) -> AlertModel {
        return AlertModel(title: "Error", message: (error as? NetworkResponce)?.rawValue ?? "")
    }
}
