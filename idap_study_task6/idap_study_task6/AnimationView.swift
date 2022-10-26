import UIKit

enum SquarePosition {
    case TopLeft
    case TopRight
    case BottomLeft
    case BottomRight

    var coordinates: (posX: Int, posY: Int) {
       switch self {
        case .TopLeft:
            return (0, 0)
        case .TopRight:
            return (50, 0)
        case .BottomLeft:
            return (0, 50)
        case .BottomRight:
            return (50, 50)
       }
    }
}

class AnimationView: UIView {
    
    @IBOutlet var square: UIView? = UIKit.UIView(frame: CGRect())
    
    func prepareView(with model: SquareInfo) {
        self.square?.backgroundColor = model.color
        self.square?.frame.origin.x = CGFloat(model.squarePosition.coordinates.posX)
        self.square?.frame.origin.y = CGFloat(model.squarePosition.coordinates.posY)
        self.square?.frame.size.width = CGFloat(model.sizeX)
        self.square?.frame.size.height = CGFloat(model.sizeY)
    }
    
    func animate(model: SquareInfo){
        UIView.animate(withDuration: 2.0, animations: {
            self.square?.frame.origin.x = self.frame.width - CGFloat(model.sizeX) 
        })
    }


}
