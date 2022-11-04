import UIKit

enum SquarePosition {
    
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
}

class AnimationView: UIView {
    
    // MARK: -
    // MARK: IBOutlets
    
    @IBOutlet var square: UIView?
    @IBOutlet var squareContainerView: UIView?

    // MARK: -
    // MARK: Public
     
    public func setSquare(position: SquarePosition, animated: Bool = false, paused: Bool = false, completion: F.Completion<Bool>? = nil) {
        UIView.animate(
            withDuration: animated ? 3.0 : 0.0,
            delay: 0,
            options: [],
            animations: {
                self.setSquarePosition(position: position)
            },
            completion: {
                completion?($0)
            }
        )
    }
    
    // MARK: -
    // MARK: Private
    
    private func setSquarePosition(position: SquarePosition) {
        switch position {
        case .topLeft:
            self.square?.frame.origin.x = 0
            self.square?.frame.origin.y = 0
        case .topRight:
            self.square?.frame.origin.x = self.horizontalValue()
            self.square?.frame.origin.y = 0
        case .bottomLeft:
            self.square?.frame.origin.x = 0
            self.square?.frame.origin.y = self.verticalValue()
        case .bottomRight:
            self.square?.frame.origin.x = self.horizontalValue()
            self.square?.frame.origin.y = self.verticalValue()
        }
    }
    
    private func horizontalValue() -> CGFloat {
        let screenWidth = self.squareContainerView?.frame.width ?? 0
        let squareSize = self.square?.frame.width ?? 0
        
        return screenWidth - squareSize
    }
    
    private func verticalValue() -> CGFloat {
        let screenHeight = self.squareContainerView?.frame.height ?? 0
        let squareSize = self.square?.frame.height ?? 0
        
        return screenHeight - squareSize
    }
}
