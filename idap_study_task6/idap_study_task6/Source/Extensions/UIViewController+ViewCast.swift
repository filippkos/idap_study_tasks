import UIKit

protocol RootViewGettable: UIViewController {
    
    associatedtype RootView: UIView
    var rootView: RootView? { get }
}

extension RootViewGettable {
    var rootView: RootView? {
        self.view as? RootView
    }
}
