import Foundation

class Accountant: Employee<Washer>, EmployeeStateProtocol {
    
    // MARK: -
    // MARK: Initializations and Deallocations

    let lock = NSLock()
    override init(name: String) {
        super.init(name: name)
    }
    
    // MARK: -
    // MARK: Public
    
    override func action(object: Washer) -> Bool {
        self.lock.lock()
        sleep(1)
        let isEnough = self.money >= self.price
        super.action(object: object)
        defer { self.lock.unlock() }
        return isEnough
    }
}
