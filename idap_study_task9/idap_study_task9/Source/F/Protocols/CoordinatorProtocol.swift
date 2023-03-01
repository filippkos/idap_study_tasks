//
//  CoordinatorProtocol.swift
//  idap_study_task9
//
//  Created by Filipp Kosenko on 01.02.2023.
//

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
