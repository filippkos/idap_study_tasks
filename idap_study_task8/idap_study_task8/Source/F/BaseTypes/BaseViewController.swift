//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: -
    // MARK: Variables
    
    private let serviceManager: ServiceManager
    
    // MARK: -
    // MARK: Init
    
    init(serviceManager: ServiceManager) {
        self.serviceManager = serviceManager
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Deinit
    
    deinit {
        debugPrint("deinit - \(type(of: self))")
    }
}
