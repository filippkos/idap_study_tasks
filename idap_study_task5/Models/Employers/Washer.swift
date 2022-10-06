import Foundation

class Washer: Employee<Car>, EmployeeStateProtocol {
    
    // MARK: -
    // MARK: Initializations and Deallocations
    
    override init(name: String) {
        super.init(name: name)
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func action(object: Car) {
        self.state = .working
        sleep(object.time)
        object.isClean = true
        self.takeMoney(another: object)
        super.action(object: object)
        self.state = .needsProcessing
        self.state = .readyToWork
    }
}
