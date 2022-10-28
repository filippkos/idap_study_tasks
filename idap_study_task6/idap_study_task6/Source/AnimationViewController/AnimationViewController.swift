import UIKit

class AnimationViewController: UIViewController {
    
    // MARK: -
    // MARK: Variables
    
    var currentView: UIView? {
        self.view != nil ? self.view : nil
    }
    
    // MARK: -
    // MARK: Initializations and Deallocations
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Overrided functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rootView = self.view()
        rootView.prepareView()
    }
}
