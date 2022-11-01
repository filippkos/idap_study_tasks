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
    
    public func setSquarePositionAnimatedWithCompletion(nextPosition: SquarePosition, animated: Bool, cycled: Bool, currentPosition: SquarePosition) -> SquarePosition {
        let duration = animated ? 3.0 : 0.0
        var position = cycled ? self.getNextposition(currentPosition: currentPosition) : nextPosition
        UIView.animate(withDuration: duration, animations: {
            self.setSquarePosition(position: position)
        }, completion:  {_ in
            if cycled {
                position = self.setSquarePositionAnimatedWithCompletion(nextPosition: position, animated: true, cycled: true, currentPosition: position)
            }
        })
        return position
    }
    
    public func pauseLayer(layer: CALayer) {
        let pausedTime: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }

    public func resumeLayer(layer: CALayer) {
        let pausedTime: CFTimeInterval = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }
    
    // MARK: -
    // MARK: Private
    
    private func getNextposition(currentPosition: SquarePosition) -> SquarePosition {
        switch currentPosition {
        case .topLeft:
            return .topRight
        case .topRight:
            return .bottomRight
        case .bottomLeft:
            return .topLeft
        case .bottomRight:
            return .bottomLeft
        }
    }
    
    private func setSquarePositionAnimated(position: SquarePosition, duration: Double) {
        UIView.animate(withDuration: duration, animations: {
            self.setSquarePosition(position: position)
        })
    }
    
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
        let squareSize = self.square?.frame.height ?? 0

        let result = (self.squareContainerView?.frame.height ?? 0) - squareSize
        
        return result
    }
}
