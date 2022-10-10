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
        self.takeMoney(another: object) 
        self.state = .needsProcessing
        self.state = .readyToWork
    }
}
