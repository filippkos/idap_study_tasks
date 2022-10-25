import UIKit

struct AnimationInfo {
    let sizeX: Int
    let sizeY: Int
    let color: UIColor
}


class AnimationViewController: UIViewController {

    let info: AnimationInfo
    
    init(model: AnimationInfo) {
        self.info = model
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rootView = self.view as? AnimationView
        rootView?.prepareView(with: self.info)
    }
}
