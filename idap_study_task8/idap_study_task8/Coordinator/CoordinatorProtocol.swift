import UIKit

public protocol Coordinator : AnyObject {
    
    func start()
    func details(name: String)
}
