import UIKit

class AnimationViewController: UIViewController {
    
    // MARK: -
    // MARK: IBActions
    
    @IBAction func topLeftButton(_ sender: Any) {
        self.squarePosition = self.rootView?.setSquarePositionAnimatedWithCompletion(nextPosition: .topLeft, animated: false, cycled: false, currentPosition: self.squarePosition) ?? self.squarePosition
    }
    
    @IBAction func topRightButton(_ sender: Any) {
        self.squarePosition = self.rootView?.setSquarePositionAnimatedWithCompletion(nextPosition: .topRight, animated: false, cycled: false, currentPosition: self.squarePosition) ?? self.squarePosition
    }
    
    @IBAction func bottomLeftButton(_ sender: Any) {
        self.squarePosition = self.rootView?.setSquarePositionAnimatedWithCompletion(nextPosition: .bottomLeft, animated: false, cycled: false, currentPosition: self.squarePosition) ?? self.squarePosition
    }
    
    @IBAction func bottomRightButton(_ sender: Any) {
        self.squarePosition = self.rootView?.setSquarePositionAnimatedWithCompletion(nextPosition: .bottomRight, animated: false, cycled: false, currentPosition: self.squarePosition) ?? self.squarePosition
    }
    
    @IBAction func topLeftButtonAnimated(_ sender: Any) {
        self.squarePosition = self.rootView?.setSquarePositionAnimatedWithCompletion(nextPosition: .topLeft, animated: true, cycled: false, currentPosition: self.squarePosition) ?? self.squarePosition
    }
    
    @IBAction func topRightButtonAnimated(_ sender: Any) {
        self.squarePosition =  self.rootView?.setSquarePositionAnimatedWithCompletion(nextPosition: .topRight, animated: true, cycled: false, currentPosition: self.squarePosition) ?? self.squarePosition
    }
    
    @IBAction func bottomLeftButtonAnimated(_ sender: Any) {
        self.squarePosition = self.rootView?.setSquarePositionAnimatedWithCompletion(nextPosition: .bottomLeft, animated: true, cycled: false, currentPosition: self.squarePosition) ?? self.squarePosition
    }
    
    @IBAction func bottomRightButtonAnimated(_ sender: Any) {
        self.squarePosition = self.rootView?.setSquarePositionAnimatedWithCompletion(nextPosition: .bottomRight, animated: true, cycled: false, currentPosition: self.squarePosition) ?? self.squarePosition
        
    }
    
    @IBAction func clockwiseMovementButton(_ sender: Any) {
            self.squarePosition = self.rootView?.setSquarePositionAnimatedWithCompletion(nextPosition: self.squarePosition, animated: true, cycled: true, currentPosition: self.squarePosition) ?? self.squarePosition
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        if let layer = self.rootView?.square?.layer {
            self.isPause = !self.isPause
            if isPause {
                self.rootView?.pauseLayer(layer: layer)
            } else {
                self.rootView?.resumeLayer(layer: layer)
            }
        }
    }
    
    // MARK: -
    // MARK: Variables
    
    private var rootView: AnimationView?
    private var animator: UIViewPropertyAnimator!
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
    // MARK: Overrided functions
    
    override func viewDidLoad() {
        
    }

}
