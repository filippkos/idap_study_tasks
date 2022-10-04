import Foundation

enum WasherEvents {
    
    case done
}

class Washer: Employee<Car>, EmployeeStateProtocol {
    
    // MARK: -
    // MARK: Variables
    
    var eventHandler: ((WasherEvents) -> ())?
    
    // MARK: -
    // MARK: Initializations and Deallocations
    
    override init(name: String) {
        super.init(name: name)
    }
    
    // MARK: -
    // MARK: Public
    
    override func action(object: Car) -> Bool {
        self.state = .working
        sleep(object.time)
        object.isClean = true
        super.takeMoney(another: object)
        self.state = .needsProcessing
        super.action(object: object)
        defer { self.state = .readyToWork }
        self.eventHandler?(.done)
        return true
    }
}
