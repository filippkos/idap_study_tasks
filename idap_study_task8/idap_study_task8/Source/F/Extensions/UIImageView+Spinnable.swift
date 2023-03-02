//Created for idap_study_task8 in 2023
// Using Swift 5.0

import Foundation
import UIKit

extension UIImageView: Spinnable {

    // MARK: -
    // MARK: Typealiases
    
    public typealias SpinnerType = SpinnerView
    
    // MARK: -
    // MARK: Variables
    
    public var isLoaded: Bool {
        get {
            false
        }
        set {
            false
        }
    }
}
