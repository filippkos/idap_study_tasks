import UIKit

enum squarePosition {
    case topLeft(Int, Int)
    case topRight(Int, Int)
    case bottomLeft(Int, Int)
    case bottomRight(Int, Int)
}

class AnimationView: UIView {

    @IBOutlet var square: UIView?

    var squarePos: squarePosition
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareView(with model: AnimationInfo) {
        
        self.square?.frame.size.width = CGFloat(model.sizeX ) 
        self.square?.frame.size.height = CGFloat(model.sizeY)
        self.square?.frame.origin.x = 0
        self.square?.frame.origin.y = 0
        self.square?.backgroundColor = model.color
    }

}
