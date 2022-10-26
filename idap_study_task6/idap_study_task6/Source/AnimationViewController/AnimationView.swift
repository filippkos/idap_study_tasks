import UIKit

enum SquarePosition {
    
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
}

class AnimationView: UIView {
    
    @IBOutlet private var square: UIView?
    @IBOutlet private var squareContainerView: UIView?
    
    private var isAnimate: Bool = false
    private var isPause: Bool = false
    private var squarePosition: SquarePosition = .topLeft
    
    public func prepareView() {
        self.animate()
    }
    
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
    
    func animationPart(time: Double, offset: CGFloat, position: SquarePosition) {
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
        
        return (self.squareContainerView?.frame.maxY ?? 0) - squareSize * 2
    }
}

extension UIScreen {
    
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
}
