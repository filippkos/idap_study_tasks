import Foundation

class Director: Employee<Accountant> {
    
    // MARK: -
    // MARK: Initializations and Deallocations
    
    override init(name: String) {
        super.init(name: name)
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func action(object: Accountant) {
        self.state = .working
        self.takeMoney(another: object)
        self.state = .needsProcessing
        self.state = .readyToWork
    }
}
