import Foundation

class Accountant: Employee<Washer>, EmployeeStateProtocol {
    
    // MARK: -
    // MARK: Initializations and Deallocations

    override init(name: String) {
        super.init(name: name)
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func action(object: Washer) {
        self.state = .working
        sleep(1)
        self.state = .needsProcessing
        if self.money >= self.price {
            super.action(object: object)
        }
        self.state = .readyToWork
    }
}
