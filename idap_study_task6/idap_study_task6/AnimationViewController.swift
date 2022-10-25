import UIKit

struct SquareInfo {
    
    let sizeX: Int
    let sizeY: Int
    let color: UIColor
    var squarePosition: SquarePosition
    
    mutating func setSqarePosition (newPosition: SquarePosition) {
        self.squarePosition = newPosition
    }
}


class AnimationViewController: UIViewController {

    let info: SquareInfo
    
    init(model: SquareInfo) {
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
