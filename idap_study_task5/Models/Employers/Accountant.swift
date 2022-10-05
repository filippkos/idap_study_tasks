import Foundation

class Accountant: Employee<Washer>, EmployeeStateProtocol {
    
    // MARK: -
    // MARK: Initializations and Deallocations

    override init(name: String) {
        super.init(name: name)
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func action(object: Washer) -> Bool {
        sleep(1)
        let isEnough = self.money >= self.price
        super.action(object: object)
        return isEnough
    }
}
