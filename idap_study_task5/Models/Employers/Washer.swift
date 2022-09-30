import Foundation

class Washer: Employee<Car>, EmployeeStateProtocol {
    
    // MARK: -
    
    // MARK: Initializations and Deallocations
    
    override init(name: String) {
        super.init(name: name)
    }
    
    // MARK: -
    
    // MARK: Public ( Public visible funcs )
    
    override func action(object: Car) -> Bool {
        self.state = .working
        sleep(object.time)
        object.isClean = true
        super.takeMoney(another: object)
        self.state = .needsProcessing
        self.moneyReceiver?.getMoney(another: self)
        defer { self.state = .readyToWork }
        return true
    }
}
