import UIKit

class AnimationViewController: UIViewController {

    
    init() {
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rootView = self.view as? AnimationView
        rootView?.prepareView()
    }
}
