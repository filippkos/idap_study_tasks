import UIKit

class AnimationViewController: UIViewController {
    
    // MARK: -
    // MARK: IBActions
    
    @IBAction func topLeftButton(_ sender: Any) {
        self.rootView?.setSquare(position: .topLeft, completion: nil)
        self.squarePosition = .topLeft
    }
    
    @IBAction func topRightButton(_ sender: Any) {
        self.rootView?.setSquare(position: .topRight, completion: nil)
        self.squarePosition = .topRight
    }
    
    @IBAction func bottomLeftButton(_ sender: Any) {
        self.rootView?.setSquare(position: .bottomLeft, completion: nil)
        self.squarePosition = .bottomLeft
    }
    
    @IBAction func bottomRightButton(_ sender: Any) {
        self.rootView?.setSquare(position: .bottomRight, completion: nil)
        self.squarePosition = .bottomRight
    }
    
    @IBAction func topLeftButtonAnimated(_ sender: Any) {
        self.rootView?.setSquare(position: .topLeft, animated: true, completion: nil)
        self.squarePosition = .topLeft
    }
    
    @IBAction func topRightButtonAnimated(_ sender: Any) {
        self.rootView?.setSquare(position: .topRight, animated: true, completion: nil)
        self.squarePosition = .topRight
    }
    
    @IBAction func bottomLeftButtonAnimated(_ sender: Any) {
        self.rootView?.setSquare(position: .bottomLeft, animated: true, completion: nil)
        self.squarePosition = .bottomLeft
    }
    
    @IBAction func bottomRightButtonAnimated(_ sender: Any) {
        self.rootView?.setSquare(position: .bottomRight, animated: true, completion: nil)
        self.squarePosition = .bottomRight
    }
    
    @IBAction func clockwiseMovementButton(_ sender: Any) {
        if !isAnimate {
            self.isAnimate = true
            self.startAnimation(position: getNextposition(currentPosition: self.squarePosition))
        }
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        self.isPause = !self.isPause
        if !self.isPause && self.isAnimate == true {
            self.startAnimation(position: getNextposition(currentPosition: self.squarePosition))
        }
    }
    
    
    // MARK: -
    // MARK: Variables
    
    private var rootView: AnimationView?
    private var isAnimate: Bool = false
    private var isPause: Bool = false
    private var squarePosition: SquarePosition = .topLeft
    
    // MARK: -
    // MARK: Initializations and Deallocations
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.rootView = self.view()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Private
    
    private func startAnimation(position: SquarePosition) {
        if self.isPause {
            return
        }
        self.rootView?.setSquare(
            position: position,
            animated: true,
            completion: {_ in
                self.squarePosition = position
                self.startAnimation(position: self.getNextposition(currentPosition: position))
            }
        )
    }
    
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
}
