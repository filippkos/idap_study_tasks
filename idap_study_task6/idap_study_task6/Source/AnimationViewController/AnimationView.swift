import UIKit

enum SquarePosition {
    
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
}

class AnimationView: UIView {
    
    // MARK: -
    // MARK: IBActions
    
    @IBAction func pauseButton(_ sender: Any) {
        if let layer = self.square?.layer {
            self.isPause = !self.isPause
            if isPause {
                self.pauseLayer(layer: layer)
            } else {
                self.resumeLayer(layer: layer)
            }
        }
    }
    
    // MARK: -
    // MARK: IBOutlets
    
    @IBOutlet private var square: UIView?
    @IBOutlet private var squareContainerView: UIView?

    // MARK: -
    // MARK: Variables
    
    private var isAnimate: Bool = false
    private var isPause: Bool = false
    private var squarePosition: SquarePosition = .topLeft
    
    // MARK: -
    // MARK: Public
    
    public func prepareView() {
        self.animate()
    }
    
    // MARK: -
    // MARK: Private
    
    private func animate() {
        if !self.isAnimate {
            self.isAnimate = true
            
            UIView.animateKeyframes(
                withDuration: 5.0,
                delay: 0,
                options: [.calculationModeLinear, .repeat],
                animations: {
                    self.animationPart(time: 0, offset: self.horizontalValue(), position: .topRight)
                    self.animationPart(time: 0.25, offset: self.verticalValue(), position: .bottomRight)
                    self.animationPart(time: 0.5, offset: 0, position: .bottomLeft)
                    self.animationPart(time: 0.75, offset: self.squareContainerView?.frame.minY ?? 0, position: .topLeft)
            }, completion: nil)
            self.isAnimate = false
        }
    }
    
    private func animationPart(time: Double, offset: CGFloat, position: SquarePosition) {
        UIView.addKeyframe(
            withRelativeStartTime: time,
            relativeDuration: 1,
            animations: { [weak self] in
                switch position {
                case .topLeft, .bottomRight:
                    self?.square?.frame.origin.y = offset
                case .topRight, .bottomLeft:
                    self?.square?.frame.origin.x = offset
                }
                self?.squarePosition = position
            }
        )
    }
    
    private func horizontalValue() -> CGFloat {
        let screenWidth = UIScreen.width
        let squareSize = self.square?.frame.width ?? 0
        
        return screenWidth - squareSize
    }
    
    private func verticalValue() -> CGFloat {
        let squareSize = self.square?.frame.height ?? 0

        let result = (self.squareContainerView?.frame.maxY ?? 0) - squareSize
        
        return result
    }
    
    private func pauseLayer(layer: CALayer) {
        let pausedTime: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }

    private func resumeLayer(layer: CALayer) {
        let pausedTime: CFTimeInterval = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }
    

}
