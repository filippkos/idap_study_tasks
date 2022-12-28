//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

class BaseViewController: UIViewController {
    
    deinit {
        debugPrint("deinit - \(type(of: self))")
    }
}
